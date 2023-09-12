package main

import (
	"database/sql"
	_ "github.com/lib/pq"

	"github.com/stretchr/testify/require"
	"testing"

	"fmt"
	"github.com/rekby/fixenv"
	"github.com/rekby/fixenv/sf"
)

func TestPutURL(t *testing.T) {
	e := New(t)
	s := EmptyStorage(e)
	testURL := "http://test.com"
	id, err := s.PutURL(sf.Context(e), testURL)
	require.NoError(t, err)
	res := s.conn.QueryRowContext(sf.Context(e), "SELECT url FROM urls WHERE id=$1", id)
	require.NoError(t, res.Err())
	var url string
	err = res.Scan(&url)
	require.NoError(t, err)
	require.Equal(t, testURL, url)
}

func TestGetURL(t *testing.T) {
	e := New(t)
	ctx := sf.Context(e)
	s := EmptyStorage(e)
	testURL := "http://test.com"
	testID := "qwer"

	_, err := s.GetURL(ctx, testID)
	require.ErrorIs(t, err, ErrNotFound)

	_, err = s.conn.ExecContext(ctx, "INSERT INTO urls (id, url) VALUES ($1, $2)", testID, testURL)
	require.NoError(t, err)

	url, err := s.GetURL(ctx, testID)
	require.NoError(t, err)
	require.Equal(t, testURL, url)
}

func EmptyStorage(e *Env) *storageLigPQ {
	return fixenv.CacheWithCleanup(e, nil, nil, func() (*storageLigPQ, fixenv.FixtureCleanupFunc, error) {
		ctx := sf.Context(e)
		conn := EmptyConnection(e)
		s, err := NewStorageLibPQ(ctx, conn)
		if err != nil {
			return nil, nil, err
		}
		_ = s.RemoveAllTables(ctx)
		err = s.Init(ctx)
		if err != nil {
			return nil, nil, err
		}
		cleanup := func() { _ = s.RemoveAllTables(ctx) }
		return s, cleanup, nil
	})
}

func EmptyConnection(e *Env) *sql.DB {
	return fixenv.CacheWithCleanup(e, nil, nil, func() (*sql.DB, fixenv.FixtureCleanupFunc, error) {
		params := PostgresConnectionParams(e)
		connectionString := fmt.Sprintf("postgres://%v:%v@%v:%v/%v?sslmode=disable",
			params.Login, params.Password, params.Host, params.Port, params.Database,
		)
		e.Logf("Connecting to database")
		driver, err := sql.Open("postgres", connectionString)
		if err != nil {
			return nil, nil, err
		}
		clean := func() { _ = driver.Close() }
		return driver, clean, nil
	})
}
