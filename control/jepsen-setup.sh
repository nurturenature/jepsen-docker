#!/bin/bash
set -e

echo "Setting up control's keys" >> /var/log/jepsen-setup.log
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp /var/jepsen/shared/control/id_rsa /root/.ssh/
chmod 600 /root/.ssh/id_rsa
cp /var/jepsen/shared/control/id_rsa.pub /root/.ssh/

echo "Getting list of nodes" >> /var/log/jepsen-setup.log
mkdir -p /jepsen
sort -V /var/jepsen/shared/nodes > /jepsen/nodes

echo "Key scanning nodes" >> /var/log/jepsen-setup.log
echo > /root/.ssh/known_hosts
while read -r node; do
  ssh-keyscan -t rsa     "$node" >> /root/.ssh/known_hosts
  ssh-keyscan -t ed25519 "$node" >> /root/.ssh/known_hosts
done < /jepsen/nodes
