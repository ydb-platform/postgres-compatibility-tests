package main

import "context"

type Storage interface {
	PutURL(ctx context.Context, url string) (ID string, _ error)
	GetURL(ctx context.Context, shortID string) (longURL string, _ error)
}
