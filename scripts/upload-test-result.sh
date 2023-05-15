#!/bin/bash

set -eu

FILENAME="$1"

[ -e ".tests-root-folder" ] || echo "Start from test root folder"
[ -e ".tests-root-folder" ] || exit 1

DIR="$PWD"
TESTMO_INSTANCE="https://bovoko8304.testmo.net"
PROJECT_ID=1
NAME="test-name"
SOURCE="test-source"
RESULTS="$FILENAME"

docker build -f ./scripts/testmo-cli.Docker ./scripts/ -t ypct-testmo-cli
docker run --rm -e "TESTMO_TOKEN=$TESTMO_TOKEN" -v "$DIR:/project" ypct-testmo-cli automation:run:submit \
    --instance "$TESTMO_URL" \
    --project-id $TESTMO_PROJECT_ID \
    --name "$NAME" \
    --source "$SOURCE" \
    --results "/project/$RESULTS"
