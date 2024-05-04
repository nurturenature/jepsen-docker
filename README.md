## [Jepsen](https://github.com/jepsen-io/jepsen) in Docker

----

This repository proposes a simplification of the current Jepsen docker environment.

```bash
# bring up a Jepsen control node and 5 db nodes
docker compose up

# open a shell into the control node
docker exec -it jepsen-control bash

# checkout repository with Jepsen test
git clone --depth 1 --branch main https://github.com/nurturenature/jepsen-causal-consistency.git

# run test
cd jepsen-causal
lein run test --workload lww-intermediate-read --rate 10 --time-limit 30

# run test result web server
lein run serve

# browse test results
http://localhost:8080
```

```bash
docker compose -f electricsql-compose.yaml -f docker-compose.yaml -f jepsen-electricsql-compose.yaml up

# open a shell into the control node
docker exec -it jepsen-control bash

# checkout repository with Jepsen test
git clone --depth 1 --branch main https://github.com/nurturenature/jepsen-causal-consistency.git

# run test
cd jepsen-causal
lein run test --workload lww-intermediate-read --rate 10 --time-limit 30

docker compose -f electricsql-compose.yaml -f docker-compose.yaml -f jepsen-electricsql-compose.yaml down

```