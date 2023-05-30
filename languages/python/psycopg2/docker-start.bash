#!/bin/bash

set -eu

rm -rf /test-result 2> /dev/null || true

mkdir -p /test-result/raw

mkdir -p /sources
cp -R /project/ /sources/

if [ -z "$(ls /sources/)" ]; then
    cp -Rn /project/ /sources/
else
    echo "Skip copy sources"
    ls /sources/
fi

cd /project

echo "Start test"
cp -f /docker-start-test.py ./
python docker-start-test.py || true

echo "Remove unprinted chars"
for FILE in $(ls /test-result/raw); do
  tr -dc '[:print:]\n' < /test-result/raw/$FILE > /test-result/tmp.xml
  mv /test-result/tmp.xml /test-result/raw/$FILE

  sed -e 's/" name="/\./' -i /test-result/raw/$FILE
  sed -e 's/<testcase classname="/<testcase classname="python-psycopg2" name="/' -i /test-result/raw/$FILE
done

