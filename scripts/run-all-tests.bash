#!/bin/bash

set -eu

if [ ! -e .tests-root-folder ]; then
  echo "Run from project root folder"
  exit 1
fi

YDB_PG_ALLTEST_RESULT_PATH="${YDB_PG_ALLTEST_RESULT_PATH:-$PWD/tmp/last-run-result.xml}"

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

scripts/run-script.bash python scripts/report-processing/merge-results.py --input-reports=./tmp/run-results \
  > "$YDB_PG_ALLTEST_RESULT_PATH"

echo "Result was output to: $YDB_PG_ALLTEST_RESULT_PATH" >&2
