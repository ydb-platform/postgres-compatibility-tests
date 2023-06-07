#!/bin/bash

docker-compose -f scripts/report-processing/docker-compose.yaml build >&2
docker-compose -f scripts/report-processing/docker-compose.yaml run scripts "$@"
