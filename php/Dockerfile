FROM ubuntu:16.04
LABEL maintainer="liuyang.z@hooowl.com"

RUN buildDeps='libpcre3 libpcre3-dev zlib1g-dev libssl-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev \
                libpng12-dev libfreetype6-dev libpspell-dev librecode-dev libxml2-dev libmcrypt-dev libcurl3-dev \
                libcurl3 wget unzip build-essential'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mkdir -p /data/softwares && cd /data/softwares \
        && wget http://cn2.php.net/distributions/php-7.2.0.tar.gz && tar -xvf php-7.2.0.tar.gz \
        && cd /data/softwares/php-7.2.0 \
        && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --enable-mysqlnd \
                        --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir \
                        --with-png-dir --with-zlib --with-curl --with-gd --with-xmlrpc --with-openssl --with-mhash \
                        --with-curlwrappers --with-libxml-dir --with-pear --with-bz2 --enable-gd-native-ttf --enable-safe-mode \
                        --enable-bcmath --enable-shmop --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-mbstring \
                        --enable-sockets --enable-magic-quotes --enable-zip --enable-soap --enable-dba --enable-exif \
                        --enable-ftp --enable-opcache \
        && make && make install \
        && cp /data/softwares/php-7.2.0/php.ini-production /usr/local/php/etc/php.ini \
        && cd /usr/local/php/etc && mv php-fpm.conf.default php-fpm.conf \
        && mv php-fpm.d/www.conf.default php-fpm.d/www.conf \
        && sed -Ei 's/user = nobody/user = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/group = nobody/group = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' php.ini \
        && chown -R www-data:www-data /usr/local/nginx /usr/local/php \
        && apt-get purge -y --auto-remove build-essential wget unzip

COPY autoRun.sh /autoRun.sh
RUN chmod a+x /autoRun.sh

ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
