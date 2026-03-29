#!/usr/bin/env bash
set -e

# use docker-build.sh built local images
# or GitHub Container Registry images
#   - export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"

docker compose \
       -f ../jepsen-compose.yaml \
       down \
       -v

docker ps --format="table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo
echo "The jepsen-control and jepsen-node containers have been stopped, any any networks/volumes deleted"
