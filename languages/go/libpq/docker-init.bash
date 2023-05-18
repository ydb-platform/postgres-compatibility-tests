#!/bin/bash

set -eu

mkdir -p /project
cd /project

go install github.com/jstemmer/go-junit-report/v2@v2.0.0

wget https://github.com/lib/pq/archive/refs/tags/v1.10.9.tar.gz -O libpq.tar.gz
tar --strip-components=1 -zxvf libpq.tar.gz
rm -f libpq.tar.gz

# cache build dependencies
go test -c -o /test.binary

