# Docker-webserver

![Nginx](https://img.shields.io/badge/Nginx-1.12.1-yellow.svg)
![PHP](https://img.shields.io/badge/PHP-7.1.7-red.svg)


NGINX 主配置文件为 `usr/local/nginx/conf/nginx.conf`

其中各虚拟主机点引用配置为 `/data/nginx-conf/*.conf`，所以如若添加虚拟主机只要将配置文件添加在 /data/nginx-conf/ 文件夹中并以 `.conf`
为扩展后缀即可。

## Dir structure
```
/data/
|-- html
|   `-- index.html
|-- nginx-conf
|   `-- *.conf
|   `-- php.ini *
|   `-- nginx *
`-- nginx-ssl
    |-- dhparam.pem
    |-- fullchain.pem
    `-- privkey.pem
```

注意，其中 * 号标注的文件再启动容器后会自动生成。如果你已经有配置好的 `nginx` 和 `php.ini` 文件则可以拷贝至 `nginx-conf` 文件夹下，启动容器时会自动应用你的配置文件到程序。

## How to use?

_Docker Pull Command_

`$ docker pull yangzl/webserver`

_Docker Run Command_

`$ docker run -ti --name webserver -v /data:/data -p 80:80 -p 443:443 webserver:latest`

## NOTICE
- 启动容器前必须确保文件结构完整，尤其是 nginx-conf 文件夹内的配置文件必须正确，否则无法正常启动。
- 容器启动后，容器内应用(NGINX PHP)自动启动。
- `/data/` 作为容器与主机的共享卷，其中凡容器内使用的文件（如配置文件、SSL证书文件）都不能使用 `ln -s` 软链接。