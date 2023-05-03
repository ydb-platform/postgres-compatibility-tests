#!/bin/bash

set -eu

DIR=$(dirname $0)
cd "$DIR"
wget https://github.com/lib/pq/archive/refs/tags/v1.10.9.tar.gz -O libpq.tar.gz

tar -zxvf libpq.tar.gz

cd pq-1.10.9

export PGUSER=root
export PGHOST=localhost
export PGPORT=5432
export PQGOSSLTESTS=0
export PQSSLCERTTEST_PATH=certs

eval $(GIMME_GO_VERSION=1.20 gimme)
PQTEST_BINARY_PARAMETERS=no go test -test.timeout=30s -v ./...
