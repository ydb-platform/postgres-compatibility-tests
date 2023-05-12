#!/bin/bash

# https://github.com/psycopg/psycopg2


set -eu

DIR="$PWD"

LOCAL_DIR=$(dirname "$0")
LOCAL_DIR=$(realpath "$LOCAL_DIR")

cd "$LOCAL_DIR"
docker-compose down -t 1 && docker-compose up --build --abort-on-container-exit
