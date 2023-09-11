package main

import (
	"context"
	"database/sql"
	"errors"
	"fmt"

	_ "github.com/lib/pq"
)

type storageLigPQ struct {
	conn *sql.DB
}

func NewStorageLibPQ(ctx context.Context, conn *sql.DB) (*storageLigPQ, error) {
	return &storageLigPQ{
		conn: conn,
	}, nil
}

func NewStorageLibPQFromConnectionString(ctx context.Context, c string) (*storageLigPQ, error) {
	conn, err := sql.Open("postgres", c)
	if err == nil {
		err = conn.PingContext(ctx)
	}
	if err != nil {
		return nil, fmt.Errorf("failed to connect: %w", err)
	}

	return NewStorageLibPQ(ctx, conn)
}

func (s *storageLigPQ) Init(ctx context.Context) error {
	_, err := s.conn.ExecContext(ctx, `CREATE TABLE urls (
    id TEXT NOT NULL PRIMARY KEY,
    url TEXT NOT NULL 
)
`)
	return err
}

func (s *storageLigPQ) RemoveAllTables(ctx context.Context) error {
	_, err := s.conn.ExecContext(ctx, "DROP TABLE IF EXISTS urls")
	return err
}

func (s *storageLigPQ) PutURL(ctx context.Context, url string) (ID string, _ error) {
	id, err := generateID()
	if err != nil {
		return "", fmt.Errorf("failed to generate short id: %w", err)
	}

	_, err = s.conn.ExecContext(ctx, "INSERT INTO urls (id, url) VALUES ($1, $2)", id, url)
	if err == nil {
		return id, nil
	}
	return "", err
}

func (s *storageLigPQ) GetURL(ctx context.Context, shortID string) (longURL string, _ error) {
	res := s.conn.QueryRowContext(ctx, "SELECT url FROM urls WHERE id=$1", shortID)
	if err := res.Err(); err != nil {
		return "", fmt.Errorf("failed to get url from database: %w", err)
	}

	err := res.Scan(&longURL)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return "", ErrNotFound
		}
		return "", fmt.Errorf("failed to get scan url to variable: %w", err)
	}

	return longURL, nil
}
