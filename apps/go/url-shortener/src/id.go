package main

import (
	"github.com/nuorder/go-shortid"
)

func generateID() (string, error) {
	return shortid.Generate()
}
