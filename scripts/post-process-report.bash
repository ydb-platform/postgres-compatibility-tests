#!/bin/bash

set -eu

TESTDIR="$1"

docker-compose -f scripts/report-processing/docker-compose.yaml run scripts python scripts/prepare-junit-xml-report.py --unit-test-file-path=$TESTDIR/unit-tests.txt --report-file-path=$TESTDIR/test-result/result.xml
docker-compose -f scripts/report-processing/docker-compose.yaml run scripts python scripts/report-processing/junit-report-converter.py --input-reports=$TESTDIR/test-result/result.xml --output-report=$TESTDIR/test-result/result.xml
