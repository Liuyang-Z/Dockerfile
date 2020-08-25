#!/usr/bin/env bash

mkdir -p /data/nginx/conf.d/
mkdir -p /data/nginx/ssl/
mkdir -p /data/html/


if ! [ -f /data/nginx/nginx.conf ]; then
    cp /usr/local/nginx/conf/nginx.conf /data/nginx/nginx.conf
    cp /usr/local/nginx/html/index.html /data/html/index.html
else
    cp -f /data/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf
fi

if ! [ -f /data/nginx/conf.d/default.conf ]; then
    cp /usr/local/nginx/conf/conf.d/default.conf /data/nginx/conf.d/default.conf
fi

/usr/local/nginx/sbin/nginx
/bin/bash