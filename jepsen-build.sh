#!/bin/bash
set -e

# build Jepsen images
docker build -t jepsen-setup:bookworm   ./jepsen-setup
docker build -t jepsen-node:bookworm    ./jepsen-node
docker build -t jepsen-control:bookworm ./jepsen-control

echo
echo "Jepsen Docker images have been built"
