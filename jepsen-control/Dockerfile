FROM jgoerzen/debian-base-minimal:bookworm AS debian-addons
FROM debian:bookworm-slim AS jepsen-control

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/

RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

ENV container=docker
STOPSIGNAL SIGRTMIN+3

# keep Debian up to date
RUN apt-get -qy update && \
    apt-get -qy upgrade

ENV LEIN_ROOT true

#
# Jepsen dependencies
#
RUN apt-get -qy update && \
    apt-get -qy install \
    curl dos2unix emacs git gnuplot graphviz htop iputils-ping libjna-java pssh screen vim wget && \
    curl -L https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz | tar -xz --strip-components=1 -C /usr/local/

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    mv lein /usr/bin && \
    chmod +x /usr/bin/lein && \
    lein self-install

# install Jepsen
WORKDIR /jepsen
ADD ./project.clj ./project.clj
RUN lein deps
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
