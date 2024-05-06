#!/bin/bash
set -e

# build Jepsen images
docker build -t jepsen-setup   ./jepsen-setup
docker build -t jepsen-node    ./jepsen-node
docker build -t jepsen-control ./jepsen-control

# FROM Jepsen images to ElectricSQL images
docker build -t electricsql-node    ./electricsql-node
docker build -t electricsql-control ./electricsql-control

echo
echo "Jepsen + ElectricSQL Docker images have been built."
echo "Bring up a Jepsen + ElectricSQL cluster with ./electricsql-up.sh" 