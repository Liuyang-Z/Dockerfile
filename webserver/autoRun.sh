#!/usr/bin/env bash

mkdir -p /data/nginx/conf.d/
mkdir -p /data/nginx/ssl/
mkdir -p /data/php/
mkdir -p /data/html/

if ! [ -f /data/php/php.ini ]; then
    cp /usr/local/php/etc/php.ini /data/php/php.ini
else
    cp -f /data/php/php.ini /usr/local/php/etc/php.ini
fi

if ! [ -f /data/nginx/nginx.conf ]; then
    cp /usr/local/nginx/conf/nginx.conf /data/nginx/nginx.conf
else
    cp -f /data/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf
fi

if ! [ -f /data/nginx/conf.d/default.conf ]; then
    cp /usr/local/nginx/conf/conf.d/default.conf /data/nginx/conf.d/default.conf
fi

/usr/local/php/sbin/php-fpm
/usr/local/nginx/sbin/nginx

/bin/bash

exit 0
