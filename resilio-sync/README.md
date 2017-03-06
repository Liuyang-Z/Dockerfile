# Resilio-sync

## How to use?

*Docker Command*

`$ docker run -ti -v /sync:/data/sync -p 8000:8000 --name sync yangzl/resilio-sync`

* `-v [your folder which you want to store the sync file]:/data/sync`
* `-p [host port]:8000`