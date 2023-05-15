#!/bin/bash

set -eu



testmo automation:run:submit-thread \
            --instance "$TESTMO_URL" \
            --run-id "$TESTMO_RUN_ID" \
            --results "tmp/test-result/**/*.xml"
