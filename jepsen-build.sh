#!/bin/bash
set -e

# build Jepsen images
docker build --progress quiet -t jepsen-setup:bookworm   ./jepsen-setup
docker build --progress quiet -t jepsen-node:bookworm    ./jepsen-node
docker build --progress quiet -t jepsen-control:bookworm ./jepsen-control

echo
echo "Jepsen Docker images have been built"
