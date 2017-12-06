# Docker-webserver

![Nginx](https://img.shields.io/badge/Nginx-1.13.7-yellow.svg)
![PHP](https://img.shields.io/badge/PHP-7.1.12-red.svg)
![OpenSSL](https://img.shields.io/badge/TLS1.3-draft--18-green.svg)


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

`$ docker run -ti --name webserver -v /data:/data -p 80:80 -p 443:443 yangzl/webserver:tls13`

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

* 对于选择在即电脑上构建镜像的用户，可以修改 Dockerfile 以便于提高软件的编译速度。即将文件中的 `make` 命令后面加上 `-j n` 如:

```
./configure
make -j 4
make install
```
其中 `n` 表示计算机 CPU 的核心数量，如果计算机用的是 4 核处理器，n 就改为 4。

* 如果需要在自己的计算机（或 VPS）上编译镜像，尤其是在机器内容少于 `1G` 的情况下很容易出现类似下面报错：

```
make: *** [ext/fileinfo/libmagic/apprentice.lo] Error 1 
```

这主要是因为编译 PHP 时内存不足所导致的，只要在 PHP 的编译选项中添加 `--disable-fileinfo` 即可解决。

## 补充二

> * TLS1.3-draft--18 分支**不支持** Nginx-CT
> * TLS1.3-draft--19 分支**支持** Nginx-CT，但 Chrome 62.0 **不支持** TLS1.3-draft--19 分支

配置 TLS 1.3 之后需要对 `nginx.conf` 进行相应的修改：

```
ssl_protocols              TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # 增加 TLSv1.3
ssl_ciphers                TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
```

包含 TLS13 是 TLS 1.3 新增的 Cipher Suite，加在最前面即可；如果你不打算继续支持 IE8，可以去掉包含 3DES 的 Cipher Suite。

## 补充三

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