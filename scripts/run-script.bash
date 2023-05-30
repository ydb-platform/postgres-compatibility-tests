#!/bin/bash

docker-compose -f scripts/report-processing/docker-compose.yaml run scripts "$@"
