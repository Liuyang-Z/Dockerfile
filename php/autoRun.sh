#!/usr/bin/env bash

mkdir -p /data/php/

if ! [ -f /data/php/php.ini ]; then
    cp /usr/local/php/etc/php.ini /data/php/php.ini
else
    cp -f /data/php/php.ini /usr/local/php/etc/php.ini
fi

/usr/local/php/sbin/php-fpm

/bin/bash

exit 0
