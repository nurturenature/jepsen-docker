# See https://salsa.debian.org/jgoerzen/docker-debian-base
# See https://hub.docker.com/r/jgoerzen/debian-base-standard
FROM jgoerzen/debian-base-minimal:bookworm AS debian-addons
FROM debian:bookworm-slim AS jepsen-node

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/

RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

ENV container=docker
STOPSIGNAL SIGRTMIN+3

# Basic system stuff
RUN apt-get -qy update && \
    apt-get -qy install \
    apt-transport-https

# Install packages
RUN apt-get -qy update && \
    apt-get -qy install \
    dos2unix openssh-server pwgen

# Install Jepsen deps
RUN apt-get -qy update && \
    apt-get -qy install \
    build-essential bzip2 ca-certificates curl dirmngr dnsutils faketime iproute2 iptables iputils-ping libzip4 logrotate lsb-release man man-db netcat-openbsd net-tools ntpdate psmisc python3 rsyslog sudo tar tcpdump unzip vim wget

# Configure SSHD
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Enable SSH server
ENV DEBBASE_SSH enabled

# setup script to be run at boot
ADD ./jepsen-setup.sh /usr/local/bin/jepsen-setup.sh
RUN chmod +x /usr/local/bin/jepsen-setup.sh

# setup done by systemd
ADD ./jepsen-setup.service /etc/systemd/system/jepsen-setup.service
RUN systemctl enable jepsen-setup.service

ENV ROOT_PASS=root
ADD ./root.password /jepsen/root.password
RUN passwd root < /jepsen/root.password

EXPOSE 22

ENTRYPOINT [ "/usr/local/bin/boot-debian-base" ]
