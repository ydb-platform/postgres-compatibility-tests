#!/bin/bash

[ -e ".tests-root-folder" ] || echo "Start from test root folder"
[ -e ".tests-root-folder" ] || exit 1

eval $(GIMME_GO_VERSION=1.20 gimme)

mkdir -p "$PWD/tmp/bin"
export GOBIN="$PWD/tmp/bin"

go install github.com/jstemmer/go-junit-report/v2@v2.0.0

