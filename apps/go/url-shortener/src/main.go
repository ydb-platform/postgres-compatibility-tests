package main

import (
	"context"
	"flag"
	"go.uber.org/zap"
	"log"
	"net/http"
)

func main() {
	cfg := readConfig()
	logger := createLogger()

	storage, err := NewStorageLibPQFromConnectionString(context.Background(), cfg.DBConnectionString)
	if err != nil {
		logger.Fatal("failed connect to storage", zap.Error(err))
	}

	err = storage.Init(context.Background())
	if err != nil {
		logger.Fatal("failed to initialize storage", zap.Error(err))
	}

	handler := NewHandler(logger, storage)

	//goland:noinspection HttpUrlsUsage
	logger.Info("Start", zap.String("listen url", "http://"+cfg.ListenAddress))
	startServer(logger, cfg.ListenAddress, handler)
}

func readConfig() Config {
	var cfg Config
	flag.StringVar(&cfg.ListenAddress, "listen", "localhost:8080", "Listen address")
	flag.StringVar(&cfg.DBConnectionString, "connection-string", "postgres://root:1234@127.0.0.1:5432/local?sslmode=disable", "Postgres connection string")
	flag.Parse()

	return cfg
}

func createLogger() *zap.Logger {
	logger, err := zap.NewDevelopment()
	if err != nil {
		log.Fatalf("Failed to initialize logger: %+v", err)
	}
	return logger
}

func startServer(logger *zap.Logger, listenAddress string, handler http.Handler) {
	server := http.Server{
		Addr:    listenAddress,
		Handler: handler,
	}
	err := server.ListenAndServe()
	logger.Fatal("Failed to start server", zap.Error(err))
}
