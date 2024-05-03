#!/bin/bash

echo "Removing shared Jepsen state" >> /var/log/jepsen-setup.log
rm -rf /var/jepsen/shared/*

echo "Generating control's keys" >> /var/log/jepsen-setup.log
mkdir -p /var/jepsen/shared/control
ssh-keygen -t rsa -N "" -f /var/jepsen/shared/control/id_rsa

echo "Generating nodes's authorized_keys" >> /var/log/jepsen-setup.log
mkdir -p /var/jepsen/shared/node
cp /var/jepsen/shared/control/id_rsa.pub /var/jepsen/shared/node/authorized_keys
