# Docker Base Image

custom docker base image. Based on Ubuntu 16.04 LTS with some custom settings.

Features:

* use tsinghua mirror as default apt source.
* add the bash script (/autoRun.sh) which will auto run when starting the docker container.
* open the force bash color prompt.
* change the clock to the Asia/Shanghai.

## How to use?


_Docker Run Command_

```bash
$ docker run -ti --name app_name -v /data:/data base-image:latest
```