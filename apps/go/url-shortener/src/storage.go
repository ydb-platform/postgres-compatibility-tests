package main

import (
	"context"
	"errors"
)

var ErrNotFound = errors.New("short url id not found")

type Storage interface {
	Init(ctx context.Context) error
	PutURL(ctx context.Context, url string) (ID string, _ error)
	GetURL(ctx context.Context, shortID string) (longURL string, _ error)
}
