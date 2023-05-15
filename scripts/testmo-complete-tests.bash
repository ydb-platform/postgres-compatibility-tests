#!/bin/bash

set -eu

testmo automation:run:complete --instance "$TESTMO_URL" --run-id "$TESTMO_RUN_ID"
