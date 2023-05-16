#!/bin/bash

set -eu

echo "Start script"

rm -rf /sources 2> /dev/null || true
rm -rf /test-result 2> /dev/null || true

mkdir -p /sources
cp -r /project/ /sources/

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

RUN_TESTS=""
if [ -n "${YDB_PG_TESTNAME:-}" ]; then
    SKIP_TESTS=""
    RUN_TESTS="$YDB_PG_TESTNAME"
fi

echo "Run test: '$RUN_TESTS'"
echo "Skip: '$SKIP_TESTS'"

echo "Start test"

PQTEST_BINARY_PARAMETERS=no go test -json -test.timeout=30s -v -test.run="$RUN_TESTS" -test.skip="$SKIP_TESTS" > test-result.json || true

go-junit-report -parser gojson < test-result.json > /test-result/go-libpq.xml
