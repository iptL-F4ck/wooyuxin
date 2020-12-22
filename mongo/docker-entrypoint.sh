#!/bin/bash
# setting up prerequisites

echo '127.0.0.1 mongodb' >> /etc/hosts
/usr/local/bin/docker-entrypoint.sh mongod --replSet rs0
