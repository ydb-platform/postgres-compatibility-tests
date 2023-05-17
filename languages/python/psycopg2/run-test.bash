#!/bin/bash

# https://github.com/psycopg/psycopg2


set -eu

DIR="$PWD"

LOCAL_DIR=$(dirname "$0")
LOCAL_DIR=$(realpath "$LOCAL_DIR")

cd "$LOCAL_DIR"
docker-compose down -t 1 && docker-compose build
if [ -z "${YDB_PG_HOST:-}" ]; then
    docker-compose up --abort-on-container-exit
else
    [ "$YDB_PG_HOST" ] && export YDB_PG_HOST=host.docker.internal
    docker-compose up project --no-deps --remove-orphans --abort-on-container-exit
fi
