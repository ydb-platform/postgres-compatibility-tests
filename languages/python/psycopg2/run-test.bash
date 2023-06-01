#!/bin/bash
# https://github.com/psycopg/psycopg2

set -eu

LOCAL_DIR=$(dirname "$0")
LOCAL_DIR=$(realpath "$LOCAL_DIR")

scripts/run-test.bash "$LOCAL_DIR"
