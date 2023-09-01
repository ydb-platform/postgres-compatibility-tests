#!/bin/bash

set -eu

TESTDIR="$1"

docker-compose -f $TESTDIR/docker-compose.yaml run --no-deps -w /exchange/sources project \
  diff -ruN /original-sources/ ./ | grep -v 'Binary files ' > $TESTDIR/patch.diff
