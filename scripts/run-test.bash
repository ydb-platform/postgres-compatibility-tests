#!/bin/bash

set -eu

TESTDIR="$1"

cd "$TESTDIR"

docker-compose down -t 1 && docker-compose build

if [ -z "${YDB_PG_HOST:-}" ]; then
    export YDB_PG_PROJECT_HOSTMODE=host
    docker-compose up --abort-on-container-exit
else
    [ "$YDB_PG_HOST" ] && export YDB_PG_HOST=host.docker.internal
    docker-compose up project --no-deps --remove-orphans --abort-on-container-exit
fi
