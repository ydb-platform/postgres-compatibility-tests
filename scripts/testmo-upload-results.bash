#!/bin/bash

set -eu

RESULT_PATH="$1"

testmo automation:run:submit-thread \
            --instance "$TESTMO_URL" \
            --run-id "$TESTMO_RUN_ID" \
            --results "$RESULT_PATH/*.xml"
