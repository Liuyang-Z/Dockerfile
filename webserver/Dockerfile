FROM ubuntu:latest
MAINTAINER Liuyang-Z "liuyang-z@hooowl.com"

RUN buildDeps='libpcre3 libpcre3-dev zlib1g-dev libssl-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev \
                libpng12-dev libfreetype6-dev libpspell-dev librecode-dev libxml2-dev libmcrypt-dev libcurl3-dev \
                libcurl3 wget unzip build-essential'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mkdir -p /data/softwares && cd /data/softwares \
        && wget http://nginx.org/download/nginx-1.12.1.tar.gz && tar -xvf nginx-1.12.1.tar.gz \
        && wget https://www.openssl.org/source/openssl-1.1.0f.tar.gz && tar -xvf openssl-1.1.0f.tar.gz && mv openssl-1.1.0f openssl \
        && wget https://github.com/grahamedgecombe/nginx-ct/archive/master.zip && unzip master.zip && mv nginx-ct-master nginx-ct \
        && rm -rf master.zip \
        && wget https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/master.zip \
        && unzip master.zip && mv ngx_http_substitutions_filter_module-master ngx_http_substitutions_filter_module && rm -rf master.zip \
        && wget http://php.net/distributions/php-7.1.7.tar.gz && tar -xvf php-7.1.7.tar.gz \
        && cd nginx-1.12.1 \
        && ./configure --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module \
                        --with-openssl=../openssl --add-module=../ngx_http_substitutions_filter_module --add-module=../nginx-ct \
        && make && make install \
        && ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib \
        && cd /data/softwares/php-7.1.7 \
        && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --enable-mysqlnd \
                        --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir \
                        --with-png-dir --with-zlib --with-curl --with-gd --with-xmlrpc --with-openssl --with-mhash \
                        --with-curlwrappers --with-libxml-dir --with-pear --with-bz2 --enable-gd-native-ttf --enable-safe-mode \
                        --enable-bcmath --enable-shmop --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-mbstring \
                        --enable-sockets --enable-magic-quotes --enable-zip --enable-soap --enable-dba --enable-exif \
                        --enable-ftp --enable-opcache \
        && make && make install \
        && cp /data/softwares/php-7.1.7/php.ini-production /usr/local/php/etc/php.ini \
        && cd /usr/local/php/etc && mv php-fpm.conf.default php-fpm.conf \
        && mv php-fpm.d/www.conf.default php-fpm.d/www.conf \
        && sed -Ei 's/user = nobody/user = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/group = nobody/group = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' php.ini \
        && chown -R www-data:www-data /usr/local/nginx /usr/local/php \
        && rm -rf /data/softwares \
        && apt-get purge -y --auto-remove build-essential wget unzip

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY autoRun.sh /autoRun.sh
RUN chmod a+x /autoRun.sh

ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
