package internal

import (
	"log"
	"os"
	"strings"

	"github.com/ydb-platform/ydb-go-genproto/protos/Ydb"
	environ "github.com/ydb-platform/ydb-go-sdk-auth-environ"
	"github.com/ydb-platform/ydb-go-sdk/v3"
	yc "github.com/ydb-platform/ydb-go-yc"
)

type YdbIssue struct {
	Message  string                   `yaml:"message"`
	Code     Ydb.StatusIds_StatusCode `yaml:"code"`
	Severity uint32                   `yaml:"severity"`
}

func ExtractIssues(err error) []YdbIssue {
	var issues []YdbIssue
	ydb.IterateByIssues(err, func(message string, code Ydb.StatusIds_StatusCode, severity uint32) {
		issues = append(issues, YdbIssue{
			Message:  strings.TrimSpace(message),
			Code:     code,
			Severity: severity,
		})
	})
	return issues
}

func GetYdbCredentials() ydb.Option {
	value, ok := os.LookupEnv("YDB_USER")
	if ok {
		username := value
		password, okp := os.LookupEnv("YDB_PASSWORD")
		if !okp {
			password = ""
		}
		return ydb.WithStaticCredentials(username, password)
	}
	value, ok = os.LookupEnv("YDB_TOKEN")
	if ok {
		return ydb.WithAccessTokenCredentials(value)
	}

	authFile := "authorized_key.json"
	if _, err := os.Stat(authFile); err == nil {
		authClient, err := yc.NewClient(yc.WithServiceFile(authFile))
		if err != nil {
			log.Printf("Failed to use service account file %q: %v", authFile, err)
		}
		return ydb.WithCredentials(authClient)
	}

	return environ.WithEnvironCredentials()
}
