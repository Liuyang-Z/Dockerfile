#!/usr/bin/env bash

mkdir -p /data/nginx-conf/

if ! [ -f /data/nginx-conf/nginx ]; then
    cp /usr/local/nginx/conf/nginx.conf /data/nginx-conf/nginx
else
    cp -f /data/nginx-conf/nginx /usr/local/nginx/conf/nginx.conf
fi

if ! [ -f /data/nginx-conf/php.ini ]; then
    cp /usr/local/php/etc/php.ini /data/nginx-conf/php.ini
else
    cp -f /data/nginx-conf/php.ini /usr/local/php/etc/php.ini
fi


/usr/local/php/sbin/php-fpm
/usr/local/nginx/sbin/nginx

/bin/bash

exit 0