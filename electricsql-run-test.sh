#!/bin/bash
set -e

docker exec \
       -t \
       -w /jepsen/jepsen-causal-consistency \
       jepsen-control \
       bash -c 'source /root/.bashrc && lein run test --workload lww-intermediate-read --rate 10 --time-limit 30'
 
echo "The test is complete."
echo "If there is a test webserver running, ./electricsql-web.sh,"
echo "Browse the results at http://localhost:8080"
