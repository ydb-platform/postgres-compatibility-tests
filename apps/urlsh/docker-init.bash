#!/bin/bash

set -eu

apt-get update && apt-get install -y patch

go install github.com/jstemmer/go-junit-report/v2@v2.0.0

mkdir -p /original-sources
cd /original-sources

wget https://github.com/adhocore/urlsh/archive/refs/tags/v1.0.1.tar.gz -O urlsh.tar.gz
tar --strip-components=1 -zxvf urlsh.tar.gz
rm -f urlsh.tar.gz

mkdir -p /project/sources/
cp -R /original-sources/. /project/sources/

[ -e /patch.diff ] && patch -s -p0 < /patch.diff

cd /project/sources/
for DIR in "controller" "middleware" "model" "orm" "request" "response" "service/url" "util"; do
  (
    echo "Building tests $DIR"
    cd "$DIR"
    go test -c -o ./test.binary
  )
done
