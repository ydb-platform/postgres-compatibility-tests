#!/bin/bash

set -eu

TESTDIR="$1"

scripts/run-script.bash python scripts/prepare-junit-xml-report.py --unit-test-file-path=$TESTDIR/unit-tests.txt --report-file-path=$TESTDIR/test-result/result.xml
scripts/run-script.bash python scripts/report-processing/junit_report_converter.py --input-reports=$TESTDIR/test-result/result.xml --output-report=$TESTDIR/test-result/result.xml
