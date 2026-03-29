#!/usr/bin/env bash
set -e

# pull jepsen-control, jepsen-node and jepsen-setup images

# expect export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"
# to use GitHub Container Registry images
if [[ -z "${JEPSEN_REGISTRY}" ]]; then
    echo "JEPSEN_REGISTRY is unset or set to the empty string!"
    exit 1
fi

echo
echo "Pulling Jepsen's Docker images from ${JEPSEN_REGISTRY}..."
echo
docker pull "${JEPSEN_REGISTRY}jepsen-control"
docker pull "${JEPSEN_REGISTRY}jepsen-node"
docker pull "${JEPSEN_REGISTRY}jepsen-setup"

echo
echo "pruning docker images..."
echo
docker image prune --force > /dev/null

echo
echo "jepsen-control, jepsen-node, and jepsen-setup images have been pulled"
