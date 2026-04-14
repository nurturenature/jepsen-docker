# Jepsen in Docker, Community Edition

----

This repository is a community supported way to run [Jepsen](https://github.com/jepsen-io/jepsen) in Docker.

It's design:

- focuses on creating fully featured images
- accepts that such images are large
  - Debian using `systemd`
  - `jepsen-control` contains all packages needed by Jepsen's Control node
  - `jepsen-node` contains
    - `jepsen.os.debian` packages
    - Nemeses
      - build clock tools
      - lazyfs
- tries to be composable with other's docker-compose.yaml, e.g. the database being tested
- primary use case is CI/CD/test/similar environments
  - when developing Jepsen tests, LXC/LXD or real VMs provide a superior experience

Images can be built locally, or images are published:

- based on Debian 13/Trixie
- install Jepsen `0.3.11`
- build/install current development version, `0.3.12-SNAPSHOT`, of Jepsen from Jepsen's GitHub repository
- built and published to the GitHub Container Registry every Sunday at 00:15
- published at:

  ```bash
  export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"
  ```

----

## Using Jepsen Images From the GitHub Container Registry

```bash
# use published Jepsen images from the registry
export JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/"

# docker shell scripts
cd bin

# pull from registry
./docker-pull.sh

# bring up a Jepsen Control node and 5 Database nodes
./docker-compose.up

# open a shell into the Control node
./jepsen-console.sh

# bring down the Jepsen cluster
./docker-compose-down.sh
```

----

## Building Jepsen Images Locally

```bash
# not using published Jepsen images from the registry
unset JEPSEN_REGISTRY

# docker shell scripts
cd bin

# build images locally
./docker-build.sh

# bring up a Jepsen Control node and 5 Database nodes
./docker-compose.up

# open a shell into the Control node
./jepsen-console.sh

# bring down the Jepsen cluster
./docker-compose-down.sh
```

----

## Building Custom Images

### Control Node

```Dockerfile
# Jepsen Control + MyDB node

ARG JEPSEN_REGISTRY

FROM ${JEPSEN_REGISTRY:-}jepsen-control

WORKDIR /jepsen
RUN git clone -b main --depth 1 --single-branch https://github.com/me/MyDB.git

# deps
WORKDIR /jepsen/MyDB
RUN lein deps
```

### Database Node

```Dockerfile
# Jepsen Database + MyClient node

ARG JEPSEN_REGISTRY

FROM ${JEPSEN_REGISTRY:-}jepsen-node

WORKDIR /jepsen
RUN git clone -b main --depth 1 --single-branch https://github.com/me/MyClient.git

# deps
WORKDIR /jepsen/MyClient
RUN npm install
```

----

## Running Jepsen Tests

Running a test on the Control node:

```bash
# replace $myTestDir with the directory of your Jepsen test on the Control node
docker exec \
       -t \
       -w $myTestDir \
       jepsen-control \
       bash -c "source /root/.bashrc && cd $myTestDir && lein run test --workload ..."
```

### Running Jepsen's Test Result Webserver

```bash
# replace $myTestDir with the directory of your Jepsen test on the Control node
docker exec \
       -t \
       -w $myTestDir \
       jepsen-control \
       bash -c "source /root/.bashrc && cd $myTestDir && lein run serve"

# launch web browser with the URI for the webserver running on Control node
cd bin
./web-browser.sh
```

----

## Composing With Others

Make Jepsen's `setup` depend on what is being tested being up and `service_healthy`:

```yaml
services:
  setup:
    depends_on:
      what_is_being_tested:
        condition: service_healthy
```

----

## Issues

### Containers Don't Have Real Clocks

Like other containers, Docker containers don't have real clocks--that means you generally can't use them to test clock skew.

### Privileged?

Jepsen introduces real environmental faults in real systems and needs the privileges to do so. Historically, it has been challenging to configure Docker to support Jepsen, and challenging for Docker to handle such configurations.

So, it's more realistic to just run:

```yaml
privileged: true
```

### Process Management

Jepsen regularly kills, pauses, resumes, and messes with process in general.
Docker will sometimes fail such requests. e.g. `kill -9 db-process`, with an exit code of 137 so will need to be retried.

### Desktop or Command Line?

Personal anecdata shows that using:

- the Docker CLI package is much more robust than the DockerDesktop package
- use images from `download.docker.com`

  ```bash
  sudo apt-get install extrepo
  sudo extrepo enable docker
  sudo apt-get update
  sudo apt-get install containerd.io \
                       docker-buildx-plugin \
                       docker-ce \
                       docker-ce-cli \
                       docker-ce-rootless-extras \
                       docker-compose-plugin
  ```
