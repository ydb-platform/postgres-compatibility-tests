#!/bin/bash

set -eu

apt-get update && apt-get install -y patch

go install github.com/jstemmer/go-junit-report/v2@v2.0.0

mkdir -p /project/sources/
cp -R /original-sources/. /project/sources/

cd /project/sources/

# cache binary
echo "Build test binary"
go test -c -o ./test.binary
