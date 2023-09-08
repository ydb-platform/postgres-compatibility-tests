#!/bin/bash

set -eu

echo "Start script"

rm -rf /test-result 2> /dev/null || true

mkdir -p /exchange
mkdir -p /test-result/raw

if [ -e /exchange/sources ]; then
    echo "Skip prepare sources, because it is exist"
else
    echo "Copy sources"
    mkdir -p /exchange/sources
    cp -Rp /project/sources-before-build/. /exchange/sources
    chmod -R og+rw /exchange/sources
fi

cd /project/sources/

export YDB_PG_TESTNAME="${YDB_PG_TESTNAME:-}"  # set YDB_PG_TESTNAME to empty string if it not set

TEST_RUN=""
if [ -n "${YDB_PG_TESTNAME:-}" ]; then
    TEST_RUN="-test.run=^$YDB_PG_TESTNAME\$"
fi

echo "Run test: '$YDB_PG_TESTNAME'"

echo "Start test"

go test -test.v $TEST_RUN ./... > /test-result/raw/result.txt || true
go-junit-report < /test-result/raw/result.txt > /test-result/raw/result.xml

# Remove unprintable chars
tr -dc '[:print:]\n' < /test-result/raw/result.xml > /test-result/tmp.xml
mv -f /test-result/tmp.xml /test-result/raw/result.xml

sed -e 's|classname="[^"]*"|classname="app-urlsh"|' -i /test-result/raw/result.xml
