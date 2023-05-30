#!/bin/bash

set -eu

TESTDIR="$1"

scripts/run-script.bash python scripts/report-processing/junit_report_converter.py --test-dir=$TESTDIR
