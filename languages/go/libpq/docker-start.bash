#!/bin/bash

set -eu

echo "Start script"

rm -rf /test-result 2> /dev/null || true

mkdir -p /sources

if [ -z "$(ls /sources/)" ]; then
    cp -Rn /project/ /sources/
else
    echo "Skip copy sources"
    ls /sources/
fi

cd /project

export YDB_PG_TESTNAME="${YDB_PG_TESTNAME:-}"  # set YDB_PG_TESTNAME to empty string if it not set

if [ -n "${YDB_PG_TESTNAME:-}" ]; then
    SKIP_TESTS="^\$"
fi

echo "Run test: '$YDB_PG_TESTNAME'"

echo "Start test"

# PQTEST_BINARY_PARAMETERS=no go test -test.skip="$SKIP_TESTS"

export SKIP_TESTS

PQTEST_BINARY_PARAMETERS=no /go-run-separate-tests.bash

sed -e 's|classname=""|classname="golang-lib-pq"|' -i /test-result/result.xml

chmod -R a+rw /test-result/
