package main

import (
	"bufio"
	"crypto/md5"
	"encoding/hex"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"sort"
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

		creations: make(map[string]map[objectType]map[string]string),
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
	ConvertSchema   bool

	parseMode converterParseMode

	creations map[string]map[objectType]map[string]string // map[scheme name][object type][name][creation sql]

	currentSchema     string
	currentName       string
	currentText       []string
	currentObjectType objectType
}

type converterParseMode int

const (
	Empty converterParseMode = iota
	CreateTable
	CreateTableExcludeSuffix
	CreateView
)

type objectType int

const (
	ObjectTypeNone objectType = iota
	ObjectTypeTable
	ObjectTypeView
)

func (c *Converter) Convert() {
	c.parseInput()
	c.formatOutPut()
}

func (c *Converter) parseInput() {
	for c.Input.Scan() {
		line := c.Input.Text()
		c.parseLine(line)
	}
}

func (c *Converter) parseLine(line string) {
	switch c.parseMode {
	case Empty:
		c.processLineEmpty(line)
	case CreateTable:
		c.processLineCreateTable(line)
	case CreateTableExcludeSuffix:
		c.processLineCreateTableExcludeSuffix(line)
	case CreateView:
		c.processLineCreateView(line)
	default:
		panic(fmt.Sprintf("Unexpected parseMode for converted process line: %v", c.parseMode))
	}
}

func (c *Converter) processLineEmpty(line string) {
	switch {
	case strings.HasPrefix(line, "CREATE TABLE "):
		c.parseMode = CreateTable
		c.currentObjectType = ObjectTypeTable
		c.currentSchema, c.currentName = extractNames(line)

		// schema workaround
		line = replaceSchemaAndName(line, c.currentSchema, c.currentName)
		c.currentText = []string{
			line,
			"__stub_primary_key SERIAL PRIMARY KEY,",
		}

	case strings.HasPrefix(line, "CREATE VIEW "):
		c.parseMode = CreateView
		c.currentObjectType = ObjectTypeView
		c.currentSchema, c.currentName = extractNames(line)
		c.currentText = nil

		// schema workaround
		line = replaceSchemaAndName(line, c.currentSchema, c.currentName)
		c.currentText = []string{line}
	default:
		return
	}
}

func (c *Converter) processLineCreateTable(line string) {
	line, hasComma := strings.CutSuffix(line, ",")
	line, _, _ = strings.Cut(line, " ENCODING ")
	if hasComma {
		line += ","
	}

	c.currentText = append(c.currentText, line)

	if line == ")" {
		c.parseMode = CreateTableExcludeSuffix
	}
}

func (c *Converter) processLineCreateTableExcludeSuffix(line string) {
	if strings.TrimSpace(line) != ";" {
		return
	}

	c.currentText = append(c.currentText, ";")
	c.saveObject()

	c.parseMode = Empty
}

func (c *Converter) processLineCreateView(line string) {
	c.currentText = append(c.currentText, line)
	if strings.HasSuffix(line, ";") {
		c.saveObject()
		c.parseMode = Empty
	}
}

func (c *Converter) saveObject() {
	if c.creations[c.currentSchema] == nil {
		c.creations[c.currentSchema] = make(map[objectType]map[string]string)
	}

	if c.creations[c.currentSchema][c.currentObjectType] == nil {
		c.creations[c.currentSchema][c.currentObjectType] = make(map[string]string)
	}

	if c.creations[c.currentSchema][c.currentObjectType][c.currentName] != "" {
		log.Printf(
			"WARNING already exists, second save skipped: %v.%v.%v",
			c.currentSchema,
			c.currentObjectType,
			c.currentName,
		)
		return
	}

	content := strings.Join(c.currentText, "\n")
	c.creations[c.currentSchema][c.currentObjectType][c.currentName] = content

	c.currentObjectType = ObjectTypeNone
	c.currentText = nil
	c.currentSchema = ""
	c.currentName = ""
}

func (c *Converter) formatOutPut() {
	//c.formatSchemas()
	//c.ensureWriteString("\n")
	c.formatObjects(ObjectTypeTable)
	//c.formatObjects(ObjectTypeView)
}

func (c *Converter) formatSchemas() {
	schemas := extractKeys(c.creations)

	sort.Strings(schemas)

	for _, name := range schemas {
		c.ensureWriteString("CREATE SCHEMA ")
		c.ensureWriteString(name)
		c.ensureWriteString(";\n")
	}
}

func (c *Converter) formatObjects(t objectType) {
	var objectTexts []string

	schemas := extractKeys(c.creations)
	for _, scheme := range schemas {
		names := extractKeys(c.creations[scheme][t])
		for _, name := range names {
			objectTexts = append(objectTexts, c.creations[scheme][t][name])
		}
	}

	outputString := strings.Join(objectTexts, "\n\n")
	c.ensureWriteString(outputString)
	c.ensureWriteString("\n")
}

func (c *Converter) ensureWriteString(s string) {
	_, err := c.Output.WriteString(s)
	if err != nil {
		const maxLineLen = 50
		if len(s) > maxLineLen {
			s = s[:maxLineLen] + "..."
		}
		log.Fatalf("Failed to write string %q: %+v", err)
	}
}

func extractNames(line string) (schemaName, tableName string) {
	words := strings.SplitN(line, " ", 4)
	names := words[2]
	schemaName, tableName, hasDot := strings.Cut(names, ".")
	if !hasDot {
		log.Fatalf("line has no dot for split name to schema and table: %q", line)
	}

	tableName, _, _ = strings.Cut(tableName, " ")
	return schemaName, tableName
}

func replaceSchemaAndName(text, schemaName, name string) string {
	from := schemaName + "." + name

	unquotedName := strings.Trim(name, "\"")
	to := schemaName + "___" + unquotedName

	const maxPgNameLen = 63
	const hashLen = 8
	const origNameLen = maxPgNameLen - hashLen

	if len(to) > maxPgNameLen {
		hash := md5.Sum([]byte(to))
		hashString := hex.EncodeToString(hash[:])
		to = to[:origNameLen] + hashString[:hashLen]
	}

	res := strings.Replace(text, from, to, -1)

	return res
}

func extractKeys[K ordered, V any](m map[K]V) []K {
	keys := make([]K, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}
	sort.Slice(keys, func(i, j int) bool {
		return keys[i] < keys[j]
	})

	return keys
}

type ordered interface {
	string | ~int
}
