#!/bin/bash

docker-compose -f scripts/report-processing/docker-compose.yaml run --build scripts "$@"
