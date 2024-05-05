#!/bin/bash
set -e

# We add our hostname to the shared volume, so that control can find us
echo "Adding hostname to shared volume" >> /var/log/jepsen-setup.log
hostname >> /var/jepsen/shared/nodes

# We make sure that node's authorized keys are ready
echo "Setting up node's authorized_keys" >> /var/log/jepsen-setup.log
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp /var/jepsen/shared/node/authorized_keys /root/.ssh/
chmod 600 /root/.ssh/authorized_keys
