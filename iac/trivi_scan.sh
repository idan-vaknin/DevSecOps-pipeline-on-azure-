#!/bin/bash

# Running Trivi Docker vulnerability scanner
docker run --rm -v $PWD:/root/ aquasec/trivy:latest image --exit-code 0 --severity HIGH,CRITICAL --no-progress $1
