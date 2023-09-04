package main

import (
	"github.com/rekby/fixenv"
	"testing"
)

type Env struct {
	*fixenv.EnvT
}

func New(t *testing.T) *Env {
	return &Env{EnvT: fixenv.New(t)}
}

func (e *Env) Logf(format string, args ...any) {
	e.T().Logf(format, args...)
}

type ConnectionParams struct {
	Host     string
	Port     string
	Database string
	Login    string
	Password string
}

func PostgresConnectionParams(e *Env) ConnectionParams {
	return ConnectionParams{
		Host:     "127.0.0.1",
		Port:     "5432",
		Database: "local",
		Login:    "root",
		Password: "1234",
	}
}
