#!/bin/bash
set -e

# build Jepsen images
docker build -t jepsen-setup   ./jepsen-setup
docker build -t jepsen-node    ./jepsen-node
docker build -t jepsen-control ./jepsen-control

echo
echo "Jepsen Docker images have been built"
