#!/bin/bash

set -eu

# Run from folder with docker-compose of postgres and filled database

TMP_FILE=original-dump.sql
docker-compose exec -e PGPASSWORD=password postgres \
  pg_dump -h localhost -U postgres -p 5432 -d local -a --column-inserts > "$TMP_FILE"

cat original-dump.sql | \
  sed -e 's/^SET .*//' | \
  sed -e 's/^SELECT pg_catalog.set_config.*//' | \
  sed -e 's/^INSERT INTO public./INSERT INTO /' | \
  sed -e "s/ ');/ '::char);/" | \
  sed -e "s/NULL);/NULL::char);/" | \
  sed -e "s/', NULL::char/'::timestamp, NULL::char/" | \
  cat > result-dump.sql
