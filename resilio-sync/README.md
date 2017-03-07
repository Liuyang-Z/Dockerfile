# Resilio-sync

## How to use?

*Docker Command*

```bash
$ docker run -d -v /sync:/data/sync -p 8000:8000 -p 55555:55555 --name sync yangzl/resilio-sync
```

* `-v [your folder which you want to store the sync file]:/data/sync`
* `-p [host port]:8000`