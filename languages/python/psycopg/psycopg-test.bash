#!/bin/bash

set -eu

DIR="$PWD"

LOCAL_DIR=$(dirname "$0")
LOCAL_DIR=$(realpath "$LOCAL_DIR")

TESTDIR="$DIR/tmp/python-psycopg"
rm -rf "$TESTDIR"
mkdir -p "$TESTDIR/src"

cd "$TESTDIR"
wget https://github.com/psycopg/psycopg2/archive/refs/tags/2.9.6.tar.gz -O psycopg2.tar.gz
tar --strip-components=1 -zxvf psycopg2.tar.gz -C src

docker-compose down -t 1 && docker-compose up --build --abort-on-container-exit
