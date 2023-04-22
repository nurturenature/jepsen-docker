## [Jepsen](https://github.com/jepsen-io/jepsen) in Docker Experiments.

----

This repository demonstrates running Jepsen tests as a CI using GitHub Actions.

### GitHub Actions

#### Publish Jepsen Docker Images

- [publish-jepsen-images.yml](.github/workflows/publish-jepsen-images.yml)

- [ghcr.io packages](https://github.com/users/nurturenature/packages?repo_name=jepsen-docker)


#### Expected to Pass Matrix

- [expected-pass-matrix.yml](.github/workflows/expected-pass-matrix.yml)
- [test results](https://github.com/nurturenature/jepsen-docker/actions/workflows/expected-pass-matrix.yml)


#### Expected to Fail Matrix

- [expected-fail-matrix.yml](.github/workflows/expected-fail-matrix.yml)
- [test results](https://github.com/nurturenature/jepsen-docker/actions/workflows/expected-fail-matrix.yml)

----

### Try It?

Download the sample [docker-compose.jepsen-sample.yml](https://raw.githubusercontent.com/nurturenature/jepsen-docker/main/docker-compose.jepsen-sample.yml)

```bash
JEPSEN_REGISTRY="ghcr.io/nurturenature/jepsen-docker/" docker compose -p jepsen -f docker-compose.jepsen-sample.yml up
```
