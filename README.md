## [Jepsen](https://github.com/jepsen-io/jepsen) in Docker

----

This repository proposes a simplification of the [current](https://github.com/jepsen-io/jepsen/jepsen/docker) Jepsen in Docker:
- more image based
- more composable

Note that:
- images are large
- fully featured systemd Debian containers

### Full Jepsen Environment

```bash
# build Docker images
docker build -t jepsen-setup   ./jepsen-setup
docker build -t jepsen-node    ./jepsen-node
docker build -t jepsen-control ./jepsen-control

# bring up a Jepsen control node and 5 db nodes
docker compose -f jepsen-compose.yaml up --detach --wait

# open a shell into the control node
docker exec -it jepsen-control bash

# remember you can run a test webserver in the control node
# that will be available from the host at http://localhost:8080
lein run serve

# bring down the Jepsen cluster
docker compose -f jepsen-compose.yaml down --volumes
```

----

### ElectricSQL Example

```bash
# add ElectricSQL to Jepsen base images
./electricsql-build.sh

# bring up by combining compose files
#   -f electricsql-compose.yaml
#   -f jepsen-compose.yaml
#   -f jepsen-electricsql-compose.yaml
./electricsql-up.sh

# create and electrify test tables
./electricsql-run-migrations.sh

# run a webserver for test results on jepsen-control
# available at http://localhost:8080
./electricsql-web.sh

# run a test
# lots of output ending with the results map
# easier to view results on test webserver
./electricsql-run-test.sh

# bring down and cleanup
#   - removes postgresql volume
#   - want to start each test with a known pristine database
./electricsql-down.sh
```
