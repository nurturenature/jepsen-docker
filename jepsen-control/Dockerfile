FROM jgoerzen/debian-base-minimal AS debian-addons
FROM debian:trixie-slim AS jepsen-control

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/

RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

ENV container=docker
STOPSIGNAL SIGRTMIN+3

ENV DEBIAN_FRONTEND=noninteractive

# keep Debian up to date
RUN apt-get -qy update && \
    apt-get -qy upgrade

ENV LEIN_ROOT=true

#
# Jepsen dependencies
#
RUN apt-get -qy update && \
    apt-get -qy install \
    curl dos2unix emacs git gnuplot graphviz htop iputils-ping libjna-java openjdk-25-jdk pssh screen vim wget

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    mv lein /usr/bin && \
    chmod +x /usr/bin/lein && \
    lein self-install

# install currently released Jepsen
WORKDIR /jepsen
ADD ./project.clj ./project.clj
RUN lein deps
WORKDIR /
RUN rm -rf /jepsen

# build/install latest Jepsen from GitHub repository
# TODO: currently a fork to support additional lazyfs commands
ARG REPO_URL=https://github.com/nurturenature/jepsen.git
ARG REPO_BRANCH=jepsen.lazyfs-enhancements
WORKDIR /jepsen
RUN git clone -b $REPO_BRANCH --depth 1 --single-branch $REPO_URL
WORKDIR /jepsen/jepsen/jepsen
RUN lein install
WORKDIR /
RUN rm -rf /jepsen

# setup script to be run at boot
ADD ./jepsen-setup.sh /usr/local/bin/jepsen-setup.sh
RUN chmod +x /usr/local/bin/jepsen-setup.sh

# setup done by systemd
ADD ./jepsen-setup.service /etc/systemd/system/jepsen-setup.service
RUN systemctl enable jepsen-setup.service

# friendly login
ADD ./bashrc /root/.bashrc
RUN dos2unix /root/.bashrc

ENTRYPOINT [ "/usr/local/bin/boot-debian-base" ]
