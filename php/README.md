# PHP in Docker

```
$ docker run -ti -v /[website]:/data/php --name php-server yangzl/php:16.04
```

* [website]: 存储 PHP 配置文件，或将已有的配置文件复制到目录中以用于 Docker 中
* Docker 内 PHP 版本为 v7.2.0
