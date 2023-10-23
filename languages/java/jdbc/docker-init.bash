#!/bin/bash

set -eu

apt-get update && apt-get install -y patch wget default-jdk-headless git

java -version

mkdir -p /original-sources
cd /original-sources

#git clone https://github.com/pgjdbc/pgjdbc.git

wget https://github.com/pgjdbc/pgjdbc/archive/refs/tags/REL42.5.4.tar.gz -O jdbc.tar.gz
tar --strip-components=1 -zxvf jdbc.tar.gz
rm -f jdbc.tar.gz

mkdir -p /project/sources/ /project/ext-sources/
cp -R /original-sources/. /project/sources/

cd /project/sources/
[ -e /patch.diff ] && patch -s -p0 < /patch.diff

cp -R /project/sources/. /project/ext-sources/

# prebuild tests

# write unexisted server for fast stub fail all tests, but build all of them
# ./gradlew postgresql:test -m
./gradlew test --continue --no-daemon --tests "org.postgresql.test.jdbc2.StatementTest.testParsingDollarQuotes" || true
./gradlew --stop
