# Docker-webserver

![Nginx](https://img.shields.io/badge/Nginx-1.18.0-green)
![OpenSSL](https://img.shields.io/badge/OpenSSL-1.1.1g-red)


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
```

注意，其中 * 号标注的文件再启动容器后会自动生成。如果你已经有配置好的 `nginx` 和 `php.ini` 文件则可以拷贝至 `nginx-conf` 文件夹下，启动容器时会自动应用你的配置文件到程序。

## 运行使用

_Docker Pull Command_

`$ docker pull yangzl/webserver`

_Docker Run Command_

`$ docker run -ti --name webserver -v /data:/data -p 80:80 -p 443:443 webserver:latest`

## 补充

* NGINX 编译选项如下：

```bash
# cd nginx-1.12.1
# ./configure \
> --with-stream \
> --with-http_v2_module \
> --with-http_ssl_module \
> --with-http_gzip_static_module \
> --with-openssl=../openssl \
> --add-module=../ngx_http_substitutions_filter_module \
> --add-module=../nginx-ct
# make && make install
```
