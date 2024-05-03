FROM jgoerzen/debian-base-minimal:bookworm as debian-addons
FROM debian:bookworm-slim

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/

RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

ENV container=docker
STOPSIGNAL SIGRTMIN+3

ENV LEIN_ROOT true

# JDK21 only in Debian testing
RUN echo "deb http://deb.debian.org/debian testing main" >> /etc/apt/sources.list
ADD ./apt-preferences /etc/apt/preferences

#
# Jepsen dependencies
#
RUN apt-get -qy update && \
    apt-get -qy install \
    curl dos2unix emacs git gnuplot graphviz htop iputils-ping libjna-java openjdk-21-jdk-headless pssh screen vim wget

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    mv lein /usr/bin && \
    chmod +x /usr/bin/lein && \
    lein self-install

# install Jepsen
ADD ./project.clj /jepsen/project.clj
RUN cd /jepsen && lein deps

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
