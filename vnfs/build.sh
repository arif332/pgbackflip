#!/bin/bash
set -e

docker build -t arif332/tng-bench-mp -f tng-bench-mp/Dockerfile tng-bench-mp

docker build -t arif332/vaaa -f vAAA/Dockerfile vAAA
