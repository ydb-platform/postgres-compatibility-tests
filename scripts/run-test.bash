#!/bin/bash

set -eu

TESTDIR="$1"

cd "$TESTDIR"

docker-compose down -t 1 && docker-compose build

if [ -z "${YDB_PG_HOST:-}" ]; then
    echo "Run test with docker ydb" >&2
    docker-compose up --exit-code-from project
else
    echo "Run test with ydb on host: $YDB_PG_HOST" >&2
    docker-compose -f docker-compose-host.yaml up project --no-deps --remove-orphans --exit-code-from project
fi
