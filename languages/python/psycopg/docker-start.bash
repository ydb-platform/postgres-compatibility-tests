#!/bin/bash

set -eu

rm -rf /sources 2> /dev/null || true
rm -rf /test-result 2> /dev/null || true

mkdir -p /sources
cp -r /project/ /sources/

cd /project

echo "Start test"
python /docker-start-test.py
