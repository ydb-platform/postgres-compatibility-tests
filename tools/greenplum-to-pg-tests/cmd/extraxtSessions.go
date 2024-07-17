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
	"slices"
	"strings"
	"time"

	"github.com/spf13/cobra"
	"github.com/ydb-platform/ydb-go-sdk/v3"
	"github.com/ydb-platform/ydb-go-sdk/v3/query"
	"gopkg.in/yaml.v3"

	"github.com/ydb-platform/postgres-compatibility-tests/tools/greenplum-to-pg-tests/internal"
)

var extractSessionsConfig struct {
	schemeDumpFile            string
	sessionsLog               string
	includeFailed             bool
	ydbConnectionString       string
	limitRequests             int
	rulesFile                 string
	writeRulesWithStat        string
	sortRulesByCount          bool
	printKnownIssues          bool
	printQueryForKnownIssue   bool
	filterReason              string
	errorLimit                int
	printErrorsInProgress     bool
	printStats                bool
	printProgressEveryQueries int
	writeStatPath             string
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
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.writeRulesWithStat, "write-updated-rules", "", "Write rules with updated stats, may be same or other file as for rules-file")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.sortRulesByCount, "sort-updates-rules-by-count", true, "")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.printKnownIssues, "print-known-issues", false, "Print known issues instead of unknown")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.printQueryForKnownIssue, "print-query-for-known-issues", true, "Print query for known issues")
	extractSessionsCmd.PersistentFlags().IntVar(&extractSessionsConfig.errorLimit, "print-errors-limit", 0, "Limit of printed errors. 0 mean infinite")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.filterReason, "reason-filter", "", "Filter printer queries and reasons by regexp")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.printErrorsInProgress, "print-progress", false, "Print queries in progress")
	extractSessionsCmd.PersistentFlags().BoolVar(&extractSessionsConfig.printStats, "print-stats", true, "Print queries in progress")
	extractSessionsCmd.PersistentFlags().IntVar(&extractSessionsConfig.printProgressEveryQueries, "print-progress-every-queries", 10, "Periodically print progress")
	extractSessionsCmd.PersistentFlags().StringVar(&extractSessionsConfig.writeStatPath, "write-stat-file", "", "Path to write full stat file if need. Will write example of queries")
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

		log.Println("Start check queries")
		var stats QueryStats
		checkQueries(rules, &stats, schema, db, sessions)

		if extractSessionsConfig.writeRulesWithStat != "" {
			rules.UpdateFromStats(stats, extractSessionsConfig.sortRulesByCount)
			if err := rules.WriteToFile(extractSessionsConfig.writeRulesWithStat); err != nil {
				log.Printf("Failed to update rules stat: %v", err)
			}
		}
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
		if limitCount > 0 && counter >= limitCount {
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

func checkQueries(rules Rules, stats *QueryStats, pgSchema *internal.PgSchema, db *ydb.Driver, sessions []internal.Session) {
	reasonFilter := regexp.MustCompile(extractSessionsConfig.filterReason)
	//checked := map[string]bool{}

	errorLimit := extractSessionsConfig.errorLimit
	if errorLimit == 0 {
		errorLimit = math.MaxInt
	}

	totalQueries := 0
	for _, session := range sessions {
		for _, transaction := range session.Transactions {
			totalQueries += len(transaction.Queries)
		}
	}

	queryIndex := 0

	for _, session := range sessions {
		for _, transaction := range session.Transactions {
			for _, pgQuery := range transaction.Queries {
				queryIndex++
				if queryIndex%extractSessionsConfig.printProgressEveryQueries == 0 {
					percent := float64(queryIndex) / float64(totalQueries) * 100
					log.Printf("Checking query %8d/%v (%v)", queryIndex, totalQueries, percent)
				}
				//if checked[pgQuery.Text] {
				//	continue
				//}
				//checked[pgQuery.Text] = true

				reason, checkResult := checkQuery(stats, rules, db, pgQuery.Text)
				if !reasonFilter.MatchString(reason) {
					continue
				}
				if !extractSessionsConfig.printKnownIssues && checkResult == checkResultErrUnknown {
					if extractSessionsConfig.printErrorsInProgress {
						log.Printf("Reason: %v\nQuery:%v\n\n", reason, pgQuery.Text)
					}
					errorLimit--
				}
				if extractSessionsConfig.printKnownIssues && checkResult == checkResultErrKnown {
					if extractSessionsConfig.printErrorsInProgress {
						log.Printf("Reason: %v", reason)
						if extractSessionsConfig.printQueryForKnownIssue {
							log.Printf("Query:\n%v\n\n", pgQuery.Text)
						}
					}
					errorLimit--
				}
				if errorLimit == 0 {
					log.Println("Error limit reached:", extractSessionsConfig.errorLimit)
					return
				}
			}
		}
	}

	if extractSessionsConfig.printStats {
		stats.PrintStats()
	}
	if extractSessionsConfig.writeStatPath != "" {
		if err := stats.SaveToFile(extractSessionsConfig.writeStatPath); err != nil {
			log.Printf("Failed to write stat: %+v", err)
		}
	}
}

type checkResultType int

const (
	checkResultOK checkResultType = iota
	checkResultErrKnown
	checkResultErrUnknown
)

func checkQuery(stat *QueryStats, rules Rules, db *ydb.Driver, queryText string) (reason string, checkResult checkResultType) {
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
		stat.CountASOK(queryText)
		return "", checkResultOK
	}

	var ydbErr ydb.Error
	errors.As(err, &ydbErr)

	issues := internal.ExtractIssues(err)

	if reason = rules.FindKnownIssue(queryText, issues); reason != "" {
		stat.CountAsKnown(reason, queryText)
		return reason, checkResultErrKnown
	}

	reason = fmt.Sprintf("%v (%v): %#v", ydbErr.Name(), ydbErr.Code(), issues)

	stat.CountAsUnknown(issues, queryText)
	return reason, checkResultErrUnknown
}

type ReplacePair struct {
	From string
	To   string
}

var schemaTableRegexp = regexp.MustCompile(`(?i)(CREATE TABLE|FROM|INSERT INTO|JOIN|UPDATE)\s+"?([^\s."]+)"?\."?([^\s."]+)"?`)

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

type QueryStats struct {
	OkCount    int
	TotalCount int

	MatchToRules    map[string]*CounterWithExample[string] // [rule name] query example
	UnknownProblems map[internal.YdbIssue]*CounterWithExample[internal.YdbIssue]
}

func (s *QueryStats) GetOkPercent() float64 {
	return float64(s.OkCount) / float64(s.TotalCount) * 100
}

func (s *QueryStats) CountASOK(query string) {
	s.TotalCount++
	s.OkCount++
}

func (s *QueryStats) CountAsKnown(ruleName string, query string) {
	s.TotalCount++
	if s.MatchToRules == nil {
		s.MatchToRules = make(map[string]*CounterWithExample[string])
	}

	var stat *CounterWithExample[string]
	var ok bool
	if stat, ok = s.MatchToRules[ruleName]; !ok {
		stat = &CounterWithExample[string]{
			ID:      ruleName,
			Example: query,
		}
		s.MatchToRules[ruleName] = stat
	}

	stat.Count++
	if len(query) < len(stat.Example) {
		stat.Example = query
	}
}

func (s *QueryStats) CountAsUnknown(issues []internal.YdbIssue, query string) {
	s.TotalCount++
	if s.UnknownProblems == nil {
		s.UnknownProblems = make(map[internal.YdbIssue]*CounterWithExample[internal.YdbIssue])
	}

	for _, issue := range issues {
		var stat *CounterWithExample[internal.YdbIssue]
		var ok bool
		if stat, ok = s.UnknownProblems[issue]; !ok {
			stat = &CounterWithExample[internal.YdbIssue]{
				ID:      issue,
				Example: query,
			}
			s.UnknownProblems[issue] = stat
		}
		stat.Count++
		if len(query) < len(stat.Example) {
			stat.Example = query
		}
	}
}

func (s *QueryStats) GetTopKnown(count int) []CounterWithExample[string] {
	return getTopCounter(s.MatchToRules, count)
}

func (s *QueryStats) GetTopUnknown(count int) []CounterWithExample[internal.YdbIssue] {
	return getTopCounter(s.UnknownProblems, count)
}

func (s *QueryStats) PrintStats() {
	fmt.Println("Queries stat.")
	fmt.Println("Ok Count:", s.OkCount)
	fmt.Println()
	fmt.Println("Known issues")
	SessionStats_printExampleCounter(getTopCounter(s.MatchToRules, 10))

	fmt.Println("New issues")
	SessionStats_printExampleCounter(getTopCounter(s.UnknownProblems, 10))
}

func SessionStats_printExampleCounter[K comparable](examples []CounterWithExample[K]) {
	for _, example := range examples {
		fmt.Printf(`
Problem: %v
Count: %v
Example: %v

`, example.ID, example.Count, example.Example)
	}
}

type CounterWithExample[K comparable] struct {
	ID      K      `yaml:"id"`
	Count   int    `yaml:"count"`
	Example string `yaml:"example"`
}

func getTopCounter[K comparable](m map[K]*CounterWithExample[K], count int) []CounterWithExample[K] {
	res := make([]CounterWithExample[K], 0, len(m))
	for _, stat := range m {
		res = append(res, *stat)
	}

	// Max counts
	slices.SortFunc(res, func(a, b CounterWithExample[K]) int {
		return b.Count - a.Count
	})

	if count >= len(res) {
		return res
	}

	return res[:count]
}

func (s *QueryStats) SaveToFile(path string) error {
	var statFile struct {
		TotalCount    int                                     `yaml:"total_count"`
		OkCount       int                                     `yaml:"ok_count"`
		OkPercent     float64                                 `yaml:"ok_percent"`
		UnknownIssues []CounterWithExample[internal.YdbIssue] `yaml:"unknown_issues"`
		KnownIssues   []CounterWithExample[string]            `yaml:"known_issues"`
	}

	statFile.TotalCount = s.TotalCount
	statFile.OkCount = s.OkCount
	statFile.OkPercent = s.GetOkPercent()
	statFile.UnknownIssues = s.GetTopUnknown(math.MaxInt)
	statFile.KnownIssues = s.GetTopKnown(math.MaxInt)

	for i := range statFile.UnknownIssues {
		statFile.UnknownIssues[i].Example = cleanStringForLiteralYaml(statFile.UnknownIssues[i].Example)
	}
	for i := range statFile.KnownIssues {
		statFile.KnownIssues[i].Example = cleanStringForLiteralYaml(statFile.KnownIssues[i].Example)
	}

	f, err := os.Create(path)
	if err != nil {
		return fmt.Errorf("failed to create file for write stat: %w", err)
	}
	defer f.Close()
	encoder := yaml.NewEncoder(f)
	if err = encoder.Encode(&statFile); err != nil {
		return fmt.Errorf("failed to write stat: %w", err)
	}
	return nil
}

func cleanStringForLiteralYaml(s string) string {
	lines := strings.Split(s, "\n")
	for i, line := range lines {
		// trim ending space
		for strings.HasSuffix(line, " ") {
			line = strings.TrimSuffix(line, " ")
		}
		lines[i] = line
	}

	s = strings.Join(lines, "\n")

	sBytes := []byte(s)
	buf := &strings.Builder{}

	// range over runes
	for i, r := range s {
		if isYamlPrintable(sBytes, i) {
			buf.WriteRune(r)
		} else {
			buf.WriteByte('X')
		}
	}

	return buf.String()
}

func isYamlPrintable(b []byte, i int) bool {
	// copy of yaml.is_printable
	return ((b[i] == 0x0A) || // . == #x0A
		(b[i] >= 0x20 && b[i] <= 0x7E) || // #x20 <= . <= #x7E
		(b[i] == 0xC2 && b[i+1] >= 0xA0) || // #0xA0 <= . <= #xD7FF
		(b[i] > 0xC2 && b[i] < 0xED) ||
		(b[i] == 0xED && b[i+1] < 0xA0) ||
		(b[i] == 0xEE) ||
		(b[i] == 0xEF && // #xE000 <= . <= #xFFFD
			!(b[i+1] == 0xBB && b[i+2] == 0xBF) && // && . != #xFEFF
			!(b[i+1] == 0xBF && (b[i+2] == 0xBE || b[i+2] == 0xBF))))
}
