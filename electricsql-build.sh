#!/bin/bash
set -e

docker build -t jepsen-setup   ./setup
docker build -t jepsen-node    ./node
docker build -t jepsen-control ./control
