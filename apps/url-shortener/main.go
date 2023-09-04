package main

import (
	"flag"
	"go.uber.org/zap"
	"log"
	"net/http"
)

func main() {
	cfg := readConfig()
	logger := createLogger()
	handler := NewHandler(logger, nil)

	startServer(logger, cfg.ListenAddress, handler)
}

func readConfig() Config {
	var cfg Config
	flag.StringVar(&cfg.ListenAddress, "listen", "localhost:8080", "Listen address")
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
