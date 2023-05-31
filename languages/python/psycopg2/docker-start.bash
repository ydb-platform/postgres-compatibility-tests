#!/bin/bash

set -eu

rm -rf /test-result 2> /dev/null || true

mkdir -p /exchange
mkdir -p /test-result/raw

if [ -e /common/sources ]; then
    echo "Skip prepare sources, because it is exist"
else
    echo "Copy sources"
    mkdir -p /exchange/sources
    cp -R /project/sources/. /exchange/sources
fi

cd /project/sources/

echo "Start test"
cp -f /docker-start-test.py ./
python docker-start-test.py || true

echo "Remove unprinted chars and fix classname"
for FILE in $(ls /test-result/raw); do
  tr -dc '[:print:]\n' < /test-result/raw/$FILE > /test-result/tmp.xml
  mv /test-result/tmp.xml /test-result/raw/$FILE

  sed -e 's/" name="/\./' -i /test-result/raw/$FILE
  sed -e 's/<testcase classname="/<testcase classname="python-psycopg2" name="/' -i /test-result/raw/$FILE
done

