#!/bin/bash

set -eu

sed -e 's/^SELECT pg_catalog.set_config.*//' | \
sed -e 's/^INSERT INTO public./INSERT INTO /' | \
sed -e "s/ ')/ '::char)/" | \
sed -e "s/NULL)/NULL::char)/" | \
sed -e "s/', NULL::char/'::timestamp, NULL::char/" | \
cat
