#!/bin/bash

set -eu

[ -z "${PGHOST:-}" ] && export PGHOST=localhost
[ -z "${PGPORT:-}" ] && export PGPORT=5432
[ -z "${PGDATABASE:-}" ] && export PGDATABASE="local"
[ -z "${PGUSER:-}" ] && export PGUSER="root"
[ -z "${PGPASSWORD:-}" ] && export PGPASSWORD="1234"
[ -z "${PGBENCH_TESTTIME:-}" ] && export PGBENCH_TESTTIME="10"


for BENCHMARK in select-only simple-update tpcb-like; do
    for PROTOCOL in simple prepared; do
        echo
        echo "$BENCHMARK $PROTOCOL"
        pgbench -n -T $PGBENCH_TESTTIME -b $BENCHMARK --protocol=$PROTOCOL
    done
done
