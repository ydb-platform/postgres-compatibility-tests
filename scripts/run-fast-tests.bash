#!/bin/bash

if [ ! -e .tests-root-folder ]; then
  echo "Run from project root folder"
  exit 1
fi

TESTS=(
  languages/go/libpq
  languages/python/psycopg2
)

rm -rf ./tmp/results
mkdir -p ./tmp/results

for TESTDIR in ${TESTS[@]}; do
  RESULT_XML="${TESTDIR////_}.xml"
  ./scripts/run-test.bash "$TESTDIR"
  ./scripts/post-process-report.bash "$TESTDIR"
  cp "$TESTDIR/test-result/result.xml" "./tmp/results/$RESULT_XML"
done

scripts/run-script.bash python scripts/report-processing/merge-results.py --input-reports=./tmp/results > ./tmp/full-result.xml
echo "Result was output to: $PWD/tmp/full-result.xml"
