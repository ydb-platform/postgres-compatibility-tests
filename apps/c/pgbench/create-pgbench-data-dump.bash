#!/bin/bash

set -eu

if [ ! -e .tests-root-folder ]; then
  echo "Run from project root folder"
  exit 1
fi

cat ./apps/pgbench/create-tables.sql

docker rm -fv postgres_bench_data >/dev/null 2>&1 || true
docker run --rm -d --name postgres_bench_data -e POSTGRES_PASSWORD=password postgres:14 >/dev/null 2>&1
echo "Wait postgres init" 1>&2
sleep 10
docker exec -e PGPASSWORD=password postgres_bench_data pgbench -U postgres -h localhost -d postgres -i
docker exec -e PGPASSWORD=password postgres_bench_data pg_dump -U postgres -h localhost -d postgres -a --column-inserts --rows-per-insert=1000 | \
  ./apps/pgbench/pg_dump_data_patch_format.sh

docker rm -fv postgres_bench_data >/dev/null 2>&1 || true
