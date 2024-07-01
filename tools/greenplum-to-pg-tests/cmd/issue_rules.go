package cmd

type PgIssueRules struct {
	Name        string
	Issue       string
	IssueRegexp []string
	QueryRegexp []string
}
