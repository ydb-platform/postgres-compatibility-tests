#!/bin/bash

set -eu

[ -e ".tests-root-folder" ] || echo "Start from test root folder"
[ -e ".tests-root-folder" ] || exit 1

if [ -n "${GITHUB_EVENT_NAME:-}" ]; then
    TESTMO_SOURCE="github-$GITHUB_EVENT_NAME"
else
    TESTMO_SOURCE="manual"
fi

TESTMO_SOURCE="${TESTMO_SOURCE/_/-}"  # Replace _ to - for workflow_dispatch

echo "Testmo source: '$TESTMO_SOURCE'"

RUN_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"

testmo automation:resources:add-field --name git --type string --value ${GITHUB_SHA} --resources resources.json
testmo automation:resources:add-link --name build --url $RUN_URL --resources resources.json

testmo automation:run:create \
    --instance "$TESTMO_URL" \
    --project-id "$TESTMO_PROJECT_ID" \
    --name "YDB Postgres compatibility" \
    --source "$TESTMO_SOURCE" \
    --resources resources.json \
        > testmo-run-id.txt

TESTMO_RUN_ID=$(cat testmo-run-id.txt)
echo "Testmo report: https://nebius.testmo.net/automation/runs/view/$ID" >> $GITHUB_STEP_SUMMARY

testmo automation:run:submit-thread \
            --instance "$TESTMO_URL" \
            --run-id "$TESTMO_RUN_ID" \
            --results "**/test-result/*.xml"

testmo automation:run:complete --instance "$TESTMO_URL" --run-id "$TESTMO_RUN_ID"

