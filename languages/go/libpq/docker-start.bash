#!/bin/bash

set -eu

echo "Start script"

rm -rf /sources 2> /dev/null || true
rm -rf /test-result 2> /dev/null || true

mkdir -p /sources
cp -R /project/ /sources/

cd /project

SKIP_TESTS="^$"

# Need check, SSL
SKIP_TESTS="$SKIP_TESTS|ExampleConnectorWithNoticeHandler"

# Skip unit tests
SKIP_TESTS="$SKIP_TESTS|^Test.*ArrayScan|^TestGenericArrayValue|Test.*ArrayValue"
for UNIT_TEST in \
    TestParseArray \
    TestParseArrayError \
    TestArrayScanner \
    TestArrayValuer \
    TestBadConn \
    TestBoolArrayValue \
    TestByteaArrayValue \
    TestCloseBadConn \
    TestErrorDuringStartupClosesConn \
    TestFloat64ArrayValue \
    TestGenericArrayValue \
    TestGenericArrayValueErrors \
    TestGenericArrayValueUnsupported \
    TestParseEnviron \
    TestParseComplete
    do
        SKIP_TESTS="$SKIP_TESTS|^$UNIT_TEST\$"
done

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
