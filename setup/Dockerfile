# See https://salsa.debian.org/jgoerzen/docker-debian-base
# See https://hub.docker.com/r/jgoerzen/debian-base-standard
FROM jgoerzen/debian-base-minimal:bookworm as debian-addons
FROM debian:bookworm-slim

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/

RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

ENV container=docker
STOPSIGNAL SIGRTMIN+3

# Basic system stuff
RUN apt-get -qy update && \
    apt-get -qy install apt-transport-https

# Install packages
RUN apt-get -qy update && \
    apt-get -qy install openssh-client

# setup script to be called by setup step in compose
ADD ./jepsen-setup.sh /usr/local/bin/jepsen-setup.sh
RUN chmod +x /usr/local/bin/jepsen-setup.sh

CMD ["/usr/local/bin/boot-debian-base"]
