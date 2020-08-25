FROM ubuntu:latest
LABEL maintainer="liuyang.z@hooowl.com"

ENV DEBIAN_FRONTEND=noninteractive
RUN buildDeps='build-essential wget unzip pkg-config bison libzip-dev git libpcre3 libpcre3-dev zlib1g-dev'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mkdir -p /data/softwares && cd /data/softwares \
        # 下载 NGINX 源码
        && wget http://nginx.org/download/nginx-1.18.0.tar.gz && tar -xvf nginx-1.18.0.tar.gz \
        # 下载 OpenSSL 库
        && wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz && tar -xvf openssl-1.1.1g.tar.gz \
        # 下载 Brotli 库
        && git clone https://github.com/google/ngx_brotli.git && cd ngx_brotli && git submodule update --init \
        && cd .. \
        # 编译 NGINX
        && cd nginx-1.18.0 \
        && ./configure --with-stream \
                        --with-http_v2_module \
                        --with-http_ssl_module \
                        --with-http_gzip_static_module \
                        --with-openssl=../openssl-1.1.1g \
                        --with-openssl-opt=enable-tls1_3 \
                        --add-module=../ngx_brotli \
        && make -j6 && make install \
        && ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib \
        # 权限及文件夹配置
        && chown -R www-data:www-data /usr/local/nginx \
        && mkdir -p /usr/local/nginx/conf/conf.d \
        && rm -rf /data/softwares \
        && apt-get purge -y --auto-remove build-essential wget unzip libzip-dev

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx.default.conf /usr/local/nginx/conf/conf.d/default.conf

COPY autoRun.sh /autoRun.sh
RUN ["chmod", "+x", "/autoRun.sh"]

ENTRYPOINT ["/autoRun.sh"]
