#!/bin/bash

set -eu

TEST_DIR="$1"
CONTAINER_NAME=ydb_test_postgres
PG_PORT=5434

docker rm -f "$CONTAINER_NAME" || true
docker run --detach --name=$CONTAINER_NAME -p $PG_PORT:5432 -e POSTGRES_PASSWORD=password --rm postgres:14

echo "Wait postgres start"
sleep 5

YDB_PG_HOST=localhost YDB_PG_PORT=$PG_PORT YDB_PG_DATABASE=postgres "$TEST_DIR/run-test.bash"

docker rm -f "$CONTAINER_NAME"

./scripts/run-script.bash python scripts/report-processing/list-tests.py \
  --input-reports=$TEST_DIR/test-result \
  | tee $TEST_DIR/full-test-list.txt

