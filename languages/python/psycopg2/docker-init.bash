#!/bin/bash

set -eu

apt-get update && apt-get install -y default-jre
curl -L -o /junit-xml-merger.jar \
    https://github.com/codeclou/java-junit-xml-merger/releases/download/1.0.1/junit-xml-merger.jar

mkdir -p /project
cd /project

wget https://github.com/psycopg/psycopg2/archive/refs/tags/2.9.6.tar.gz -O psycopg2.tar.gz
tar --strip-components=1 -zxvf psycopg2.tar.gz
rm -f psycopg2.tar.gz

pip install "xmlrunner < 4"

python setup.py build
python setup.py install
