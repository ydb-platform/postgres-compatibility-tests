#!/bin/bash

# https://github.com/lib/pq

set -eu

[ -e ".tests-root-folder" ] || echo "Start from test root folder"
[ -e ".tests-root-folder" ] || exit 1

./scripts/install-go-test-converter.sh

DIR="$PWD"

TESTDIR="$DIR/tmp/go-libpq"
rm -rf "$TESTDIR"
mkdir -p "$TESTDIR/src"
mkdir -p "$DIR/tmp/test-result"
cd "$TESTDIR"

wget https://github.com/lib/pq/archive/refs/tags/v1.10.9.tar.gz -O "$TESTDIR/libpq.tar.gz"
tar --strip-components=1 -zxvf libpq.tar.gz -C src

export PGUSER=root
export PGHOST=localhost
export PGPORT=5432
export PQGOSSLTESTS=0
export PQSSLCERTTEST_PATH=certs

eval $(GIMME_GO_VERSION=1.20 gimme)
cd src
echo "Start test" >&2

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
echo "skip: $SKIP_TESTS"

PQTEST_BINARY_PARAMETERS=no go test -json -test.timeout=30s -v -test.skip="$SKIP_TESTS" > ../test-result.json || true

cd "$DIR"
echo "Convert result" >&2
./tmp/bin/go-junit-report -parser gojson < "$TESTDIR/test-result.json" > "$DIR/tmp/test-result/go-libpq-1.xml"

echo "Finished" >&2
