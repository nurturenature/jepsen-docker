#!/usr/bin/env bash
set -e

# use docker-build.sh built local images,
# or GitHub Container Registry images:
#   - export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"

docker compose \
       -f ../jepsen-compose.yaml \
       up \
       --detach \
       --wait

docker ps --format="table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo
echo "A full jepsen-control and jepsen-nodes cluster is up and available"
