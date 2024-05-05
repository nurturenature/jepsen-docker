#!/bin/bash
set -e

docker exec -d -t \
       -w /jepsen/jepsen-causal-consistency \
       jepsen-control \
       lein run serve
 
 echo "Test web server http://localhost:8080"
 