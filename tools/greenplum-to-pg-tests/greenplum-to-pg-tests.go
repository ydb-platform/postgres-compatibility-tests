package main

import (
	"flag"
	"io"
	"log"
	"os"

	"github.com/ydb-platform/postgres-compatibility-tests/tools/greenplum-to-pg-tests/internal"
)

type Config struct {
	InputFilePath        string
	OutputFilePath       string
	CommentExcludedLines bool
}

func main() {
	cfg := initConfig()

	reader := openReader(cfg.InputFilePath)
	defer func() { _ = reader.Close() }()

	writer := openWriter(cfg.OutputFilePath)
	defer func() { _ = writer.Close() }()

	c := internal.NewPgSchema()

	c.CommentExcluded = cfg.CommentExcludedLines

	c.Read(reader)
	if err := c.Write(writer); err != nil {
		log.Fatalf("Failed output: %+v", err)
	}
}

func initConfig() Config {
	var cfg Config
	flag.StringVar(&cfg.InputFilePath, "input-file", "", "Path to input sql file with schema. Read from stdin by default.")
	flag.StringVar(&cfg.OutputFilePath, "output-file", "", "Path to result of convertation. Stdout by default.")
	flag.BoolVar(&cfg.CommentExcludedLines, "comment-excluded", false, "Comment excluded lines instead of remove it")
	flag.Parse()

	return cfg
}

func openReader(path string) io.ReadCloser {
	if path == "" {
		return io.NopCloser(os.Stdin)
	}
	return must(os.Open(path))
}

func openWriter(path string) io.WriteCloser {
	if path == "" {
		return os.Stdout
	}
	return must(os.Create(path))
}

func must0(err error) {
	if err != nil {
		panic(err)
	}
}

func must[R any](res R, err error) R {
	must0(err)
	return res
}
