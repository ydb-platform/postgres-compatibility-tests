#!/bin/bash

set -eu

docker rm -f postgres_bench_data || true
docker run --rm -d --name postgres_bench_data -e POSTGRES_PASSWORD=password postgres:14
echo "Wait postgres init"
sleep 10
docker exec -e PGPASSWORD=password postgres_bench_data pgbench -U postgres -h localhost -d postgres -i
docker exec -e PGPASSWORD=password postgres_bench_data pg_dump -U postgres -h localhost -d postgres -a --column-inserts | \
  ./apps/pgbench/pg_dump_data_patch_format.sh

docker rm -f postgres_bench_data || true
