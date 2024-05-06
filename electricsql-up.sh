#!/bin/bash
set -e

export APP_NAME=electric-sqlite3-client

docker compose \
       -f electricsql-compose.yaml \
       -f jepsen-compose.yaml \
       -f jepsen-electricsql-compose.yaml \
       up \
       --detach \
       --wait

echo
echo "A full Jepsen + ElectricSQL cluster is up and available:"
echo
docker ps
echo
echo "A test can be run with ./electricsql-run-test.sh"
