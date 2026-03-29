#!/usr/bin/env bash
set -e

# build control, node and setup images

docker build \
       -t jepsen-control \
       ../jepsen-control

docker build \
       -t jepsen-node \
       ../jepsen-node

docker build \
       -t jepsen-setup \
       ../jepsen-setup

echo
echo "pruning docker images..."
echo
docker image prune --force > /dev/null

echo
echo "jepsen-control, jepsen-node, and jepsen-setup images have been built"
