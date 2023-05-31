#!/bin/bash

set -eu

pip install "xmlrunner < 4"

mkdir -p /original-sources
cd /original-sources

wget https://github.com/psycopg/psycopg2/archive/refs/tags/2.9.6.tar.gz -O psycopg2.tar.gz
tar --strip-components=1 -zxvf psycopg2.tar.gz
rm -f psycopg2.tar.gz

mkdir -p /project/sources/
cp -R /original-sources/. /project/sources/

[-e /patch.diff ] && patch -c -d /project/sources/ < /patch.diff

python setup.py build
python setup.py install
