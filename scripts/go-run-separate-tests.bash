#!/bin/bash

set -eu

ONE_TEST_TIMEOUT=5s
TEST_BINARY=/test.binary

GO_LIST_FILTER="^Test"

if [ -n "${YDB_PG_TESTNAME:-}" ]; then
    GO_LIST_FILTER="^${YDB_PG_TESTNAME%%/*}\$"  # Cut subtest name: TestAbc/sub -> ^TestAbc$
fi

TESTS=$($TEST_BINARY --test.list "$GO_LIST_FILTER" | sort)

echo "Skip tests: '$SKIP_TESTS'"
echo "Shell $SHELL"

for TEST_NAME in $TESTS; do
    echo -n "Test: $TEST_NAME "
    if echo "$TEST_NAME" | grep -Eq "$SKIP_TESTS"; then
        echo skip
        continue
    else
        echo start
    fi
    CMD="$TEST_BINARY --test.run '^$TEST_NAME\$' --test.v --test.timeout='$ONE_TEST_TIMEOUT'"
    echo "$CMD"
    bash -c "$CMD" >> /test-result/result.txt 2>&1 || true
done

go-junit-report < /test-result/result.txt > /test-result/result.xml
