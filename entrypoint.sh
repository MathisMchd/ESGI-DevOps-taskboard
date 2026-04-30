#!/bin/sh
set -e

mkdir -p /home/deploy/.ssh

echo "$SSH_PUBLIC_KEY" > /home/deploy/.ssh/authorized_keys

chown -R deploy:deploy /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chmod 600 /home/deploy/.ssh/authorized_keys

exec /usr/sbin/sshd -D