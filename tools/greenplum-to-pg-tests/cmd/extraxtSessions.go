/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"math"
	"os"
	"regexp"
	"strings"
	"time"

	"github.com/spf13/cobra"
	"github.com/ydb-platform/ydb-go-sdk/v3"
	"github.com/ydb-platform/ydb-go-sdk/v3/query"

	"github.com/ydb-platform/postgres-compatibility-tests/tools/greenplum-to-pg-tests/internal"
)

var extractSessionsConfig struct {
	schemeDumpFile      string
	sessionsLog         string
	includeFailed       bool
	ydbConnectionString string
	limitRequests       int
	rulesFile           string
	printKnownIssues    bool
	errorLimit          int
}

func init() {
	rootCmd.AddCommand(extractSessionsCmd)

	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.schemeDumpFile, "schemedump-file", "", "Path to dump of db schema. Set empty for skip read schema.")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.sessionsLog, "query-log", "", "Set path to input sessions log")
	must0(extractSessionsCmd.MarkPersistentFlagRequired("query-log"))

	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.includeFailed, "include-failed", false, "Extract sessions with failed transactions")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.ydbConnectionString, "ydb-connection", "grpc://localhost:2136/local", "Connection string to ydb server for check queries")
	extractSessionsCmd.PersistentFlags().IntVar(&extractSessionsConfig.limitRequests, "requests-limit", 1000, "Limit number of parse requests, 0 mean unlimited")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.rulesFile, "rules-file", "issues.yaml", "Rules for detect issue. Set empty for skip read rules.")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.printKnownIssues, "print-known-issues", false, "Print known issues instead of unknown")
	extractSessionsCmd.PersistentFlags().IntVar(&extractSessionsConfig.errorLimit, "print-errors-limit", 0, "Limit of printed errors. 0 mean infinite")
}

// extraxtSessionsCmd represents the extraxtSessions command
var extractSessionsCmd = &cobra.Command{
	Use:   "extract-sessions",
	Short: "Read session queryies log end extract sessions to files",
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()

		var rules Rules
		if extractSessionsConfig.rulesFile == "" {
			log.Println("Skip read rules file.")
		} else {
			log.Printf("Reading rules file %q...", extractSessionsConfig.rulesFile)
			if err := rules.LoadFromFile(extractSessionsConfig.rulesFile); err != nil {
				log.Fatalf("Failed to read rules file: %v", err)
			}
		}

		schema := internal.NewPgSchema()
		if extractSessionsConfig.schemeDumpFile == "" {
			log.Println("Skip read session")
		} else {
			log.Println("Reading schema.. ")
			schemaFile, err := os.Open(extractSessionsConfig.schemeDumpFile)
			if err != nil {
				log.Fatalf("Failed to open scheme file")
			}

			schema.Read(schemaFile)
			_ = schemaFile.Close()
		}

		log.Println("Connecting to ydb...")
		connectCtx, cancel := context.WithTimeout(ctx, time.Second*10)
		db := must(ydb.Open(
			connectCtx, extractSessionsConfig.ydbConnectionString,
			internal.GetYdbCredentials(),
		))
		cancel()

		sessions := readSessions()
		checkQueries(rules, schema, db, sessions)
	},
}

func readSessions() []internal.Session {
	reader := must(os.Open(extractSessionsConfig.sessionsLog))
	defer reader.Close()

	decoder := json.NewDecoder(reader)

	sortedLogs := map[int]map[int]map[int]map[int]internal.SessionLogRecord{} // pid/session/transaction/query

	limitCount := extractSessionsConfig.limitRequests

	counter := 0

	log.Println("Start reading file...")
readLoop:
	for {
		if limitCount > 0 && counter > limitCount {
			log.Println("Reached limit for parse request count:", limitCount)
			break
		}

		counter++
		if counter%1000 == 0 {
			print(".")
		}
		var entry internal.SessionLogRecord
		err := decoder.Decode(&entry)
		if errors.Is(err, io.EOF) {
			break readLoop
		}
		if errors.Is(err, io.ErrUnexpectedEOF) {
			log.Println("Unexpected EOF")
			break readLoop
		}
		if err != nil {
			log.Printf("failed to parse line: %v\n", err)
			continue readLoop
		}

		if sortedLogs[entry.ProcessID] == nil {
			sortedLogs[entry.ProcessID] = make(map[int]map[int]map[int]internal.SessionLogRecord)
		}
		if sortedLogs[entry.ProcessID][entry.SessionID] == nil {
			sortedLogs[entry.ProcessID][entry.SessionID] = make(map[int]map[int]internal.SessionLogRecord)
		}
		if sortedLogs[entry.ProcessID][entry.SessionID][entry.TransactionCount] == nil {
			sortedLogs[entry.ProcessID][entry.SessionID][entry.TransactionCount] = make(map[int]internal.SessionLogRecord)
		}
		if _, exists := sortedLogs[entry.ProcessID][entry.SessionID][entry.TransactionCount][entry.QueryCount]; exists {
			log.Printf("duplicated record: %v/%v/%v\n", entry.SessionID, entry.TransactionCount, entry.QueryCount)
			continue readLoop
		}

		sortedLogs[entry.ProcessID][entry.SessionID][entry.TransactionCount][entry.QueryCount] = entry
	}

	log.Println("Scanned entries:", len(sortedLogs))
	log.Println("Sort by sessions")

	var res []internal.Session

	pids := internal.GetSortedKeys(sortedLogs)
	for _, pid := range pids {
		sessionIDs := internal.GetSortedKeys(sortedLogs[pid])
		for _, sessionID := range sessionIDs {
			var session internal.Session
			session.ID = fmt.Sprintf("%v-%v", pid, sessionID)

			transactionNums := internal.GetSortedKeys(sortedLogs[pid][sessionID])
			for _, transactionNum := range transactionNums {
				transaction := internal.Transaction{
					Number: transactionNum,
				}

				queryIDs := internal.GetSortedKeys(sortedLogs[pid][sessionID][transactionNum])
				for _, queryID := range queryIDs {
					entry := sortedLogs[pid][sessionID][transactionNum][queryID]
					transaction.Queries = append(transaction.Queries, internal.Query{
						Number: entry.QueryCount,
						Text:   entry.Query,
					})
					if !entry.TransactionSuccess {
						transaction.Success = false
					}
				}
				session.Transactions = append(session.Transactions, transaction)
			}

			res = append(res, session)
		}
	}

	return res
}

func checkQueries(rules Rules, pgSchema *internal.PgSchema, db *ydb.Driver, sessions []internal.Session) {
	checked := map[string]bool{}

	limit := extractSessionsConfig.errorLimit
	if limit == 0 {
		limit = math.MaxInt
	}

	for _, session := range sessions {
		for _, transaction := range session.Transactions {
			for _, pgQuery := range transaction.Queries {
				if checked[pgQuery.Text] {
					continue
				}
				checked[pgQuery.Text] = true

				reason, checkResult := checkQuery(rules, db, pgQuery.Text)
				if !extractSessionsConfig.printKnownIssues && checkResult == checkResultErrUnknown {
					log.Printf("Reason: %v\nQuery:%v\n\n", reason, pgQuery.Text)
					limit--
				}
				if extractSessionsConfig.printKnownIssues && checkResult == checkResultErrKnown {
					log.Printf("Reason: %v", reason)
					limit--
				}
				if limit == 0 {
					log.Println("Print error limit reached:", extractSessionsConfig.errorLimit)
					return
				}
			}
		}
	}
}

type checkResultType int

const (
	checkResultOK checkResultType = iota
	checkResultErrKnown
	checkResultErrUnknown
)

func checkQuery(rules Rules, db *ydb.Driver, queryText string) (reason string, checkResult checkResultType) {
	queryText = strings.TrimSpace(queryText)
	queryText = fixSchemaNames(queryText)
	queryText = fixCreateTable(queryText)

	ctx := context.Background()
	res, err := db.Query().Execute(
		ctx,
		queryText,
		query.WithExecMode(query.ExecModeExplain),
		query.WithSyntax(query.SyntaxPostgreSQL),
	)
	if res != nil {
		_ = res.Close(ctx)
	}

	if err == nil {
		return "", checkResultOK
	}

	var ydbErr ydb.Error
	errors.As(err, &ydbErr)

	issues := internal.ExtractIssues(err)

	if reason = rules.FindKnownIssue(queryText, issues); reason != "" {
		return reason, checkResultErrKnown
	}

	reason = fmt.Sprintf("%v (%v): %#v", ydbErr.Name(), ydbErr.Code(), issues)

	return reason, checkResultErrUnknown
}

type ReplacePair struct {
	From string
	To   string
}

var schemaTableRegexp = regexp.MustCompile(`(?i)(CREATE TABLE|FROM|INSERT INTO|JOIN|UPDATE)\s+"?([^\s.]+)"?\."?([^\s.]+)"?`)

func fixSchemaNames(queryText string) string {
	queryText = schemaTableRegexp.ReplaceAllString(queryText, "${1} ${2}___${3}")
	return queryText
}

var createTableRegexp = regexp.MustCompile(`^(?i)(CREATE TABLE.*\()`)

func fixCreateTable(queryText string) string {
	if !strings.Contains(queryText, "CREATE TABLE") {
		return queryText
	}

	queryText = createTableRegexp.ReplaceAllString(queryText, "$1 __stub_primary_key SERIAL PRIMARY KEY,")
	return queryText
}
