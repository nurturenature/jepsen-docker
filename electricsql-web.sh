#!/bin/bash
set -e

docker exec -d -t \
       -w /jepsen/jepsen-causal-consistency \
       jepsen-control \
       lein run serve
 
 echo
 echo "Test web server is available at http://localhost:8080"
 