#!/bin/bash

set -eu

TESTDIR="$1"

cd "$TESTDIR"

docker-compose down -t 1 && docker-compose build

if [ -z "${YDB_PG_HOST:-}" ]; then
    docker-compose up --abort-on-container-exit
else
    docker-compose -f docker-compose-host.yaml up project --no-deps --remove-orphans --abort-on-container-exit
fi
