package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"strings"
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

	c := Converter{
		Input:           bufio.NewScanner(reader),
		Output:          bufio.NewWriter(writer),
		CommentExcluded: cfg.CommentExcludedLines,

		schemas: make(map[string]bool),
	}

	c.Convert()
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

type Converter struct {
	Input           *bufio.Scanner
	Output          *bufio.Writer
	CommentExcluded bool

	parseMode converterParseMode
	schemas   map[string]bool
}

type converterParseMode int

const (
	Empty converterParseMode = iota
	CreateTable
	CreateTableExcludeSuffix
	CreateView
)

func (c *Converter) Convert() {
	for c.Input.Scan() {
		line := c.Input.Text()
		result := c.processLine(line)
		if result != "" && !strings.HasSuffix(result, "\n") {
			result += "\n"
		}
		_, err := c.Output.WriteString(result)
		if err != nil {
			log.Fatalf("Failed to write line %q: %+v", result, err)
		}
	}
}

func (c *Converter) processLine(line string) string {
	switch c.parseMode {
	case Empty:
		return c.processLineEmpty(line)
	case CreateTable:
		return c.processLineCreateTable(line)
	case CreateTableExcludeSuffix:
		return c.processLineCreateTableExcludeSuffix(line)
	case CreateView:
		return c.processLineCreateView(line)
	default:
		panic(fmt.Sprintf("Unexpected parseMode for converted process line: %v", c.parseMode))
	}
}

func (c *Converter) processLineEmpty(line string) string {
	switch {
	case strings.HasPrefix(line, "CREATE SCHEMA "):

		schemaName := strings.TrimPrefix(line, "CREATE SCHEMA ")
		schemaName = strings.TrimSuffix(schemaName, ";")

		return c.createSchema(schemaName)
	case strings.HasPrefix(line, "CREATE TABLE "):
		c.parseMode = CreateTable

		schemaName := strings.TrimPrefix(line, "CREATE TABLE ")
		schemaName, _, _ = strings.Cut(schemaName, ".")

		if !c.schemas[schemaName] {
			line = c.createSchema(schemaName) + line
		}

		return line
	case strings.HasPrefix(line, "CREATE VIEW "):
		c.parseMode = CreateView

		schemaName := strings.TrimPrefix(line, "CREATE VIEW ")
		schemaName, _, _ = strings.Cut(schemaName, ".")

		if !c.schemas[schemaName] {
			line = c.createSchema(schemaName) + line
		}

		return line
	default:
		return ""
	}
}

func (c *Converter) processLineCreateTable(line string) string {
	if line == ")" {
		c.parseMode = CreateTableExcludeSuffix
		return ")"
	}

	line, hasComma := strings.CutSuffix(line, ",")
	line, _, _ = strings.Cut(line, " ENCODING ")
	if hasComma {
		line += ","
	}
	return line
}

func (c *Converter) processLineCreateTableExcludeSuffix(line string) string {
	if strings.TrimSpace(line) == ";" {
		c.parseMode = Empty
		return ";\n\n"
	}

	return ""
}

func (c *Converter) processLineCreateView(line string) string {
	if strings.HasSuffix(line, ";") {
		c.parseMode = Empty
		line += "\n\n"
	}

	return line
}

func (c *Converter) createSchema(schemaName string) string {
	c.schemas[schemaName] = true
	return "CREATE SCHEMA " + schemaName + ";\n"
}
