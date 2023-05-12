#!/bin/bash

set -eu

mkdir -p /project
cd /project
wget https://github.com/psycopg/psycopg2/archive/refs/tags/2.9.6.tar.gz -O psycopg2.tar.gz
tar --strip-components=1 -zxvf psycopg2.tar.gz
rm -rf psycopg2.tar.gz
