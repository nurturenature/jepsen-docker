#!/bin/bash
set -e

docker build -t jepsen-setup   ./jepsen-setup
docker build -t jepsen-node    ./jepsen-node
docker build -t jepsen-control ./jepsen-control

echo
echo "Docker images have been built."
echo "Bring up a Jepsen + ElectricSQL cluster with ./electricsql-up.sh" 