FROM ubuntu:16.04
LABEL maintainer="liuyang.z@hooowl.com"

RUN buildDeps='build-essential wget unzip pkg-config bison libzip-dev git libpcre3 libpcre3-dev zlib1g-dev'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mkdir -p /data/softwares && cd /data/softwares \
        # 下载 NGINX 源码
        && wget http://nginx.org/download/nginx-1.16.0.tar.gz && tar -xvf nginx-1.16.0.tar.gz \
        # OpenSSL 库
        && wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz && tar -xvf openssl-1.1.1c.tar.gz \
        # nginx-ct 模块
        && git clone https://github.com/grahamedgecombe/nginx-ct.git \
        # 编译 NGINX
        && cd nginx-1.16.0 \
        && ./configure --with-stream \
                        --with-http_v2_module \
                        --with-http_ssl_module \
                        --with-http_gzip_static_module \
                        --with-openssl=../openssl-1.1.1c \
                        --with-openssl-opt=enable-tls1_3 \
                        --add-module=../nginx-ct \
        && make -j6 && make install \
        && ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib \
        # 权限及文件夹配置
        && chown -R www-data:www-data /usr/local/nginx \
        && mkdir -p /usr/local/nginx/conf/conf.d \
        && rm -rf /data/softwares \
        && apt-get purge -y --auto-remove build-essential wget unzip

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx.default.conf /usr/local/nginx/conf/conf.d/default.conf
COPY autoRun.sh /autoRun.sh
RUN chmod a+x /autoRun.sh

ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
