#!/bin/bash

set -eu

rm -rf /sources 2> /dev/null || true
rm -rf /test-result 2> /dev/null || true

mkdir -p /sources
cp -R /project/ /sources/

cd /project

echo "Start test"
cp -f /docker-start-test.py ./
python docker-start-test.py || true

which java
java -jar /junit-xml-merger.jar -i=/test-result/raw/ -o /test-result/python-psycopg2.xml -s "python-psycopg2"

rm -rf /test-result/raw

sed -e 's/" name="/\./' -i /test-result/python-psycopg2.xml
sed -e 's/<testcase classname="/<testcase classname="python-psycopg2" name="/' -i /test-result/python-psycopg2.xml
