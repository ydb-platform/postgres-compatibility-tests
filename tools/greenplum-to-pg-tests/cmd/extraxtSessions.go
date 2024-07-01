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
	sessionsLog         string
	includeFailed       bool
	ydbConnectionString string
	limitRequests       int
}

func init() {
	rootCmd.AddCommand(extractSessionsCmd)

	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.sessionsLog, "input-file", "", "Set path to input sessions log")
	must0(extractSessionsCmd.MarkPersistentFlagRequired("input-file"))

	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.includeFailed, "include-failed", false, "Extract sessions with failed transactions")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.ydbConnectionString, "ydb-connection", "grpc://localhost:2136/local", "Connection string to ydb server for check queries")
	extractSessionsCmd.PersistentFlags().IntVar(&extractSessionsConfig.limitRequests, "requests-limit", 1000, "Limit number of parse requests, 0 mean unlimited")
}

// extraxtSessionsCmd represents the extraxtSessions command
var extractSessionsCmd = &cobra.Command{
	Use:   "extract-sessions",
	Short: "Read session queryies log end extract sessions to files",
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()

		log.Println("Connecting to ydb...")
		connectCtx, cancel := context.WithTimeout(ctx, time.Second*10)
		db := must(ydb.Open(
			connectCtx, extractSessionsConfig.ydbConnectionString,
			internal.GetYdbCredentials(),
		))
		cancel()

		sessions := readSessions()
		checkQueries(db, sessions)
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

	pids := getSortedKeys(sortedLogs)
	for _, pid := range pids {
		sessionIDs := getSortedKeys(sortedLogs[pid])
		for _, sessionID := range sessionIDs {
			var session internal.Session
			session.ID = fmt.Sprintf("%v-%v", pid, sessionID)

			transactionNums := getSortedKeys(sortedLogs[pid][sessionID])
			for _, transactionNum := range transactionNums {
				transaction := internal.Transaction{
					Number: transactionNum,
				}

				queryIDs := getSortedKeys(sortedLogs[pid][sessionID][transactionNum])
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

func checkQueries(db *ydb.Driver, sessions []internal.Session) {
	checked := map[string]bool{}

	for _, session := range sessions {
		for _, transaction := range session.Transactions {
			for _, pgQuery := range transaction.Queries {
				if checked[pgQuery.Text] {
					continue
				}
				reason, ok := checkQuery(db, pgQuery.Text)

				if !ok {
					log.Println(reason)
				}

				checked[pgQuery.Text] = true
			}
		}
	}
}

func checkQuery(db *ydb.Driver, queryText string) (reason string, ok bool) {
	//queryText = "--!syntax_pg\n" + queryText
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
		return "", true
	}

	issues := internal.ExtractIssues(err)

	reason = detectProblem(queryText, issues)

	return reason, false
}

func detectProblem(query string, issues []internal.YdbIssue) string {
	query = strings.ToUpper(query)
	for _, issue := range issues {
		if reason, known := isKnownProblem(query, issue); known {
			return reason
		}
	}

	reason := fmt.Sprint(issues)
	return reason
}

func isKnownProblem(q string, issue internal.YdbIssue) (reason string, known bool) {
	if reason, known = isGreenplumError(q, issue); known {
		return reason, known
	}

	if strings.HasPrefix(issue.Message, "Unknown cluster: ") {
		return "Unknown scheme", true
	}

	if issue.Message == "ROLLBACK not supported inside YDB query" {
		return "ROLLBACK not supported", true
	}
	if issue.Message == "COMMIT not supported inside YDB query" {
		return "COMMIT not supported", true
	}

	if strings.HasPrefix(issue.Message, "RawStmt: alternative is not implemented yet : ") {
		return "YQL:" + issue.Message, true
	}

	if strings.HasPrefix(issue.Message, "FuncCall: expected pg_catalog, but got: ") {
		return "Call function from own schema", true
	}

	if issue.Message == "ERROR:  syntax error at end of input" {
		return "Partial request", true
	}

	if issue.Message == "Expected type cast node as is_local arg, but got node with tag" {
		return "YQL: Expected type cast node as is_local arg, but got node with tag", true
	}

	if strings.HasPrefix(issue.Message, "unrecognized configuration parameter ") {
		return "PG: unrecognized configuration parameter", true
	}

	if strings.HasPrefix(issue.Message, "InsertStmt: not supported onConflictClause") {
		return "PG: InsertStmt: not supported onConflictClause", true
	}

	if strings.HasPrefix(issue.Message, "RangeFunction: unsupported coldeflist") {
		return "PG: RangeFunction: unsupported coldeflist", true
	}

	if issue.Message == "A_Expr_Kind unsupported value: 4" {
		return "PG: Support NOT DISTINCT", true
	}

	return "", false
}

func isGreenplumError(q string, issue internal.YdbIssue) (reason string, known bool) {
	if strings.HasPrefix(issue.Message, "VariableSetStmt, not supported name: gp_") {
		return "Greenplum: unsupported VariableSetStmt", true
	}

	if strings.HasPrefix(issue.Message, "No such column: sess_id") && strings.Contains(q, "PG_STAT_ACTIVITY") {
		return "Greenplum: column pg_stat_activity.sess_id", true
	}

	if issue.Message == "ERROR:  syntax error at or near \"external\"" && strings.HasPrefix(q, "DROP EXTERNAL TABLE ") {
		return "Greenplum DDL: DROP EXTERNAL TABLE", true
	}

	if (issue.Message == `ERROR:  syntax error at or near "RANDOMLY"` ||
		issue.Message == `ERROR:  syntax error at or near "DISTRIBUTED"`) && reDistributedRandomly.MatchString(q) {
		return "Greenplum DDL: DISTRIBUTED RANDOMLY", true
	}

	return "", false
}

var (
	reDistributedRandomly = regexp.MustCompile(`DISTRIBUTED\s+RANDOMLY`)
)
