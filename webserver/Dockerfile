FROM yangzl/base-image:latest
MAINTAINER YANG-ZL "zlyang65@gmail.com"

RUN buildDeps='libpcre3 libpcre3-dev zlib1g-dev libssl-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev \
                libpng12-dev libfreetype6-dev libpspell-dev librecode-dev libxml2-dev libmcrypt-dev libcurl3-dev \
                libcurl3 wget unzip build-essential'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mkdir -p /data/softwares && cd /data/softwares \
        && wget http://nginx.org/download/nginx-1.10.3.tar.gz && tar -xvf nginx-1.10.3.tar.gz \
        && wget https://www.openssl.org/source/openssl-1.1.0d.tar.gz && tar -xvf openssl-1.1.0d.tar.gz && mv openssl-1.1.0d openssl \
        && wget https://github.com/grahamedgecombe/nginx-ct/archive/master.zip && unzip master.zip && mv nginx-ct-master nginx-ct \
        && rm -rf master.zip \
        && wget https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/master.zip \
        && unzip master.zip && mv ngx_http_substitutions_filter_module-master ngx_http_substitutions_filter_module && rm -rf master.zip \
        && wget http://jp2.php.net/distributions/php-7.1.1.tar.gz && tar -xvf php-7.1.1.tar.gz \
        && cd nginx-1.10.3 \
        && ./configure --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module \
                        --with-openssl=../openssl --add-module=../ngx_http_substitutions_filter_module --add-module=../nginx-ct \
        && make && make install \
        && ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib \
        && cd /data/softwares/php-7.1.1 \
        && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --enable-mysqlnd \
                        --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir \
                        --with-png-dir --with-zlib --with-curl --with-gd --with-xmlrpc --with-openssl --with-mhash \
                        --with-curlwrappers --with-libxml-dir --with-pear --with-bz2 --enable-gd-native-ttf --enable-safe-mode \
                        --enable-bcmath --enable-shmop --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-mbstring \
                        --enable-sockets --enable-magic-quotes --enable-zip --enable-soap --enable-dba --enable-exif \
                        --enable-ftp --enable-opcache \
        && make && make install \
        && cp /data/softwares/php-7.1.1/php.ini-production /usr/local/php/etc/php.ini \
        && cd /usr/local/php/etc && mv php-fpm.conf.default php-fpm.conf \
        && mv php-fpm.d/www.conf.default php-fpm.d/www.conf \
        && sed -Ei 's/user = nobody/user = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/group = nobody/group = www-data/g' ./php-fpm.d/www.conf \
        && sed -Ei 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' php.ini \
        && chown -R www-data:www-data /usr/local/nginx /usr/local/php \
        && rm -rf /data/softwares \
        && apt-get purge -y --auto-remove build-essential wget unzip

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
RUN set -x \
        && sed -Ei '2a /usr/local/php/sbin/php-fpm' /autoRun.sh \
        && sed -Ei '3a /usr/local/nginx/sbin/nginx' /autoRun.sh \
        && sed -Ei '2a zend_extension=opcache.so\nopcache.memory_consumption=128\nopcache.interned_strings_buffer=8\n \
opcache.max_accelerated_files=4000\nopcache.revalidate_freq=60\nopcache.fast_shutdown=1\n \
opcache.enable_cli=1' /usr/local/php/etc/php.ini
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]




