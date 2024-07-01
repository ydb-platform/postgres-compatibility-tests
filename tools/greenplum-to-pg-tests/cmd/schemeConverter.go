/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"io"
	"log"
	"os"

	"github.com/spf13/cobra"

	"github.com/ydb-platform/postgres-compatibility-tests/tools/greenplum-to-pg-tests/internal"
)

var schemeConvertedConfig struct {
	InputFilePath        string
	OutputFilePath       string
	CommentExcludedLines bool
}

// schemeConverterCmd represents the schemeConverter command
var schemeConverterCmd = &cobra.Command{
	Use:   "scheme-converter",
	Short: "Convert greenplum scheme dump to postgres syntax",
	Run: func(cmd *cobra.Command, args []string) {
		reader := openReader(schemeConvertedConfig.InputFilePath)
		defer func() { _ = reader.Close() }()

		writer := openWriter(schemeConvertedConfig.OutputFilePath)
		defer func() { _ = writer.Close() }()

		c := internal.NewPgSchema()

		c.CommentExcluded = schemeConvertedConfig.CommentExcludedLines

		c.Read(reader)
		if err := c.Write(writer); err != nil {
			log.Fatalf("Failed output: %+v", err)
		}
	},
}

func init() {
	rootCmd.AddCommand(schemeConverterCmd)

	schemeConverterCmd.PersistentFlags().StringVar(&schemeConvertedConfig.InputFilePath, "input-file", "", "Path to input sql file with schema. Read from stdin by default.")
	schemeConverterCmd.PersistentFlags().StringVar(&schemeConvertedConfig.OutputFilePath, "output-file", "", "Path to result of convertation. Stdout by default.")
	schemeConverterCmd.PersistentFlags().BoolVar(&schemeConvertedConfig.CommentExcludedLines, "comment-excluded", false, "Comment excluded lines instead of remove it")

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
