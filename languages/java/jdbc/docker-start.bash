#!/bin/bash

set -eu

echo "Start script"

rm -rf /test-result 2> /dev/null || true

mkdir -p /exchange
mkdir -p /test-result/raw

if [ -e /exchange/sources ]; then
    echo "Skip prepare sources, because it is exist"
else
    echo "Copy sources"
    mkdir -p /exchange/sources
    cp -R /project/sources/. /exchange/sources
fi

cd /project/sources/

export YDB_PG_TESTNAME="${YDB_PG_TESTNAME:-}"  # set YDB_PG_TESTNAME to empty string if it not set

cat <<EOF > build.local.properties
server=$YDB_PG_HOST
port=$YDB_PG_PORT
database=$YDB_PG_DATABASE
username=$YDB_PG_USER
privilegedUser=$YDB_PG_USER
password=$YDB_PG_PASSWORD
privilegedPassword=$YDB_PG_PASSWORD
EOF

echo "config:"
cat ./build.local.properties
echo
echo

# ./gradlew postgresql:test
# ./gradlew test --offline --no-daemon --no-rebuild --build-cache $YDB_PG_TESTNAME
if [ -z "$YDB_PG_TESTNAME" ]; then
    ./gradlew --no-configuration-cache postgresql:test --build-cache --no-daemon --continue >/test-result/gradle.log 2>&1 || true
else
    ./gradlew --no-configuration-cache test --build-cache --continue --no-daemon --tests "$YDB_PG_TESTNAME" 2>&1 | tee /test-result/gradle.log || true
fi

mv ./pgjdbc/build/test-results /test-result/raw
rm -rf /test-result/raw/binary

for FOLDER in  /exchange /test-result; do
    find "$FOLDER" -type d -exec chmod a+rwx {} \;
    chmod -R a+rw "$FOLDER"
done

# rewrite testname
for FILE in $(find /test-result/raw -name '*.xml'); do
    sed -r 's/<testcase name="([^"]*)" classname="([^"]*)"/<testcase name="\2.\1" classname="java-pgjdbc"/' -i $FILE
    sed -r 's/&#/__code/g' -i $FILE
done
