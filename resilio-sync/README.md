# Resilio-sync

## Dir structure

This is the directory structure in docker container.
```bash
/data/
|-- resilio
    |-- config # storage the config files
    `-- sync   # storage the sync files
```

## How to use?

*Docker Command*

```bash
$ docker run -d -v /sync:/data/resilio -p 8000:8888 -p 55555:55555 --name sync yangzl/resilio-sync
```

* `-v [your folder which you want to store the sync file]:/data/resilio`
* `-p [host port]:8888`
* `-p [host port]:55555`

ps. The host port, you can custom it as you want.