#!/bin/bash

set -eu

RUN_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"

testmo automation:resources:add-field --name git --type string --value ${GITHUB_SHA} --resources resources.json
testmo automation:resources:add-link --name build --url $RUN_URL --resources resources.json

testmo automation:run:create \
    --instance "$TESTMO_URL" \
    --project-id "$TESTMO_PROJECT_ID" \
    --name "YDB Postgres compatibility" \
    --resources resources.json \
    --source "github" > testmo-run-id.txt

ID=$(cat testmo-run-id.txt)
echo "testmo-run-id=$ID"
echo "$GITHUB_OUTPUT"

echo "testmo-run-id=$ID" >> "$GITHUB_OUTPUT"
