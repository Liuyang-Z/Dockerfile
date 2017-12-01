# Docker-webserver

![Nginx](https://img.shields.io/badge/Nginx-1.12.1-yellow.svg)
![PHP](https://img.shields.io/badge/PHP-7.1.7-red.svg)
![OpenSSL](https://img.shields.io/badge/OpenSSL-1.1.0F-blue.svg)


NGINX 主配置文件为 `usr/local/nginx/conf/nginx.conf`

其中各虚拟主机点引用配置为 `/data/nginx-conf/*.conf`，所以如若添加虚拟主机只要将配置文件添加在 /data/nginx-conf/ 文件夹中并以 `.conf`
为扩展后缀即可。

## 目录结构
```
/data/
|-- html
|   `-- index.php
|-- nginx
|   |-- conf.d 
|   |   `-- default.conf *
|   |-- ssl
|   |   |-- fullchain.pem 
|   |   `-- privkey.pem
|   `-- nginx.conf *
`-- php
    `-- php.ini *
```

注意，其中 * 号标注的文件再启动容器后会自动生成。如果你已经有配置好的 `nginx` 和 `php.ini` 文件则可以拷贝至 `nginx-conf` 文件夹下，启动容器时会自动应用你的配置文件到程序。

## 运行使用

_Docker Pull Command_

`$ docker pull yangzl/webserver`

_Docker Run Command_

`$ docker run -ti --name webserver -v /data:/data -p 80:80 -p 443:443 yangzl/webserver:latest`

## PHP 打开 zend 缓存

将下面代码段拷贝至 `/data/php/php.ini` 中，重启容器即可。

```bash
zend_extension=opcache.so
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=1
```
## 补充一

配置 TLS 1.3 之后需要对 `nginx.conf` 进行相应的修改：

```
ssl_protocols              TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # 增加 TLSv1.3
ssl_ciphers                TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
```

包含 TLS13 是 TLS 1.3 新增的 Cipher Suite，加在最前面即可；如果你不打算继续支持 IE8，可以去掉包含 3DES 的 Cipher Suite。

## 补充二

* NGINX 编译选项如下：

```bash
# cd nginx-1.12.1
#./configure \
> --add-module=../ngx_brotli \
> --with-openssl=../openssl \
> --add-module=../ngx_http_substitutions_filter_module \
> --add-module=../nginx-ct \
> --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers' \
> --with-stream \
> --with-http_v2_module \
> --with-http_ssl_module \
> --with-http_gzip_static_module
# make && make install
```

* PHP 编译选项如下：

```bash
# cd php-7.1.7
> ./configure \
> --prefix=/usr/local/php \
> --with-config-file-path=/usr/local/php/etc \
> --enable-fpm \
> --enable-mysqlnd \
> --with-mysqli=mysqlnd \
> --with-pdo-mysql=mysqlnd \
> --with-iconv-dir \
> --with-freetype-dir \
> --with-jpeg-dir \
> --with-png-dir \
> --with-zlib \
> --with-curl \
> --with-gd \
> --with-xmlrpc \
> --with-openssl \
> --with-mhash \
> --with-libxml-dir \
> --with-pear \
> --with-bz2 \
> --with-libzip \
> --enable-bcmath \
> --enable-shmop \
> --enable-sysvsem \
> --enable-sysvshm \
> --enable-sysvmsg \
> --enable-mbstring \
> --enable-sockets \
> --enable-zip \
> --enable-soap \
> --enable-dba \
> --enable-exif \
> --enable-ftp \
> --enable-opcache
# make && make install
```