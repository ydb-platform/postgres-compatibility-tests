#!/bin/bash

set -eu

TESTDIR="$1"

docker-compose -f $TESTDIR/docker-compose.yaml run --no-deps -w /exchange/sources project \
  diff -c /original-sources/ ./ > $TESTDIR/patch.diff
