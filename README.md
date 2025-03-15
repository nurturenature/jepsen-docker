## [Jepsen](https://github.com/jepsen-io/jepsen) in Docker

----

This repository proposes a simplification of the [current](https://github.com/jepsen-io/jepsen/jepsen/docker) Jepsen in Docker:
- more image based
- more composable

Note that:
- images are large
- fully featured systemd Debian containers

Sample images:
- use Jepsen `0.3.8`
- are published at:
  ```bash
  export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"
  ```
- are built and published every Sunday at 00:15

----

### Full Jepsen Environment

```bash
# build Docker images
docker build -t jepsen-setup   ./jepsen-setup
docker build -t jepsen-node    ./jepsen-node
docker build -t jepsen-control ./jepsen-control

# or, use published Jepsen images from the registry
export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"

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
