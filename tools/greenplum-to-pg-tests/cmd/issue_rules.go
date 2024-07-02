package cmd

import (
	"errors"
	"fmt"
	"os"
	"regexp"

	"gopkg.in/yaml.v3"

	"github.com/ydb-platform/postgres-compatibility-tests/tools/greenplum-to-pg-tests/internal"
)

type Rules struct {
	Issues []PgIssueRules
}

func (r *Rules) LoadFromFile(path string) error {
	r.Issues = nil

	f, err := os.Open(path)
	if err != nil {
		return fmt.Errorf("failed to open file with issue rules %q: %v", path, err)
	}
	defer f.Close()

	decoder := yaml.NewDecoder(f)
	decoder.KnownFields(true)

	err = decoder.Decode(r)
	if err != nil {
		return fmt.Errorf("failed to parse issue rules file: %q: %v", path, err)
	}

	knownNames := map[string]bool{}
	for i := range r.Issues {
		issue := &r.Issues[i]

		if knownNames[issue.Name] {
			return fmt.Errorf("name of the issue duplicated: %q", issue.Name)
		}
		knownNames[issue.Name] = true

		err = issue.Init()
		if err != nil {
			return fmt.Errorf("failed to init rule %q in file %q: %v", issue.Name, path, err)
		}
	}

	return nil
}

func (r *Rules) FindKnownIssue(queryText string, ydbIssues []internal.YdbIssue) string {
	for _, ydbIssue := range ydbIssues {
		for _, item := range r.Issues {
			if item.IsMatched(queryText, ydbIssue) {
				return item.Name
			}
		}
	}

	return ""
}

type PgIssueRules struct {
	Name        string           `yaml:"name"`
	Tag         OneOrSliceString `yaml:"tag"`
	IssueLink   string           `yaml:"issue_link"`
	IssueRegexp OneOrSliceString `yaml:"issue_regexp"`
	QueryRegexp OneOrSliceString `yaml:"query_regexp"`
	Example     string           `yaml:"example"`
	Comment     string           `yaml:"comment"`

	issuesRegexpCompiled []*regexp.Regexp
	queryRegexpCompiled  []*regexp.Regexp
}

func (r *PgIssueRules) Init() error {
	if len(r.IssueRegexp) == 0 && len(r.QueryRegexp) == 0 {
		return errors.New("empty rule")
	}

	r.issuesRegexpCompiled = make([]*regexp.Regexp, len(r.IssueRegexp))
	var err error
	for i, text := range r.IssueRegexp {
		r.issuesRegexpCompiled[i], err = regexp.Compile(text)
		if err != nil {
			return fmt.Errorf("failed to compile issue regexp %q: %+v", text, err)
		}
	}

	r.queryRegexpCompiled = make([]*regexp.Regexp, len(r.QueryRegexp))
	for i, text := range r.QueryRegexp {
		r.queryRegexpCompiled[i], err = regexp.Compile(text)
		if err != nil {
			return fmt.Errorf("failed to compile query regexp %q: %+v", text, err)
		}
	}

	return nil
}

func (r *PgIssueRules) IsMatched(query string, issue internal.YdbIssue) bool {
	allowByIssues := len(r.IssueRegexp) == 0
	for _, re := range r.issuesRegexpCompiled {
		if re.MatchString(issue.Message) {
			allowByIssues = true
			break
		}
	}
	if !allowByIssues {
		return false
	}

	allowByQuery := len(r.QueryRegexp) == 0
	for _, re := range r.queryRegexpCompiled {
		if re.MatchString(query) {
			allowByQuery = true
			break
		}
	}

	return allowByQuery
}

type OneOrSliceString []string

func (s *OneOrSliceString) Strings() []string {
	if s == nil {
		return nil
	}
	return *s
}

func (s *OneOrSliceString) UnmarshalYAML(value *yaml.Node) error {
	var slice []string
	if value.Decode(&slice) == nil {
		*s = slice
		return nil
	}

	var str string
	if err := value.Decode(&str); err != nil {
		return err
	}
	*s = OneOrSliceString{str}
	return nil
}
