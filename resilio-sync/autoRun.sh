#!/usr/bin/env bash

mkdir -p /data/resilio/sync
mkdir -p /data/resilio/config

if ! [ -f /data/resilio/config/sync.conf ]; then
    cp /etc/sync.conf.default /data/resilio/config/sync.conf
fi

/usr/bin/rslsync --nodaemon --config /data/resilio/config/sync.conf >> /var/log/rslsync.log 2>&1

/bin/bash

exit 0