#!/bin/bash

set -eu

sed -e 's/^INSERT INTO public./INSERT INTO /' | \
cat
