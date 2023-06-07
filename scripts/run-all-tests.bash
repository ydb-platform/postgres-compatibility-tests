#!/bin/bash

set -eu

YDB_PG_ALLTESTS_RESULT_NAME="${YDB_PG_ALLTESTS_RESULT_NAME:-last}"

if [ ! -e .tests-root-folder ]; then
  echo "Run from project root folder"
  exit 1
fi

TESTS=(
  languages/go/libpq
#  languages/python/psycopg2
)

rm -rf ./tmp/run-results
mkdir -p ./tmp/run-results
mkdir -p ./tmp/alltest-result


for TESTDIR in ${TESTS[@]}; do
  RESULT_XML="${TESTDIR////_}.xml"
  ./scripts/run-test.bash "$TESTDIR"
  ./scripts/post-process-report.bash "$TESTDIR"
  cp "$TESTDIR/test-result/result.xml" "./tmp/run-results/$RESULT_XML"
done

RUN_RESULT_PATH="$PWD/tmp/alltest-result/$YDB_PG_ALLTESTS_RESULT_NAME.xml"
scripts/run-script.bash python scripts/report-processing/merge-results.py --input-reports=./tmp/run-results \
  > "$RUN_RESULT_PATH"

echo "Result was output to: $RUN_RESULT_PATH" >&2

