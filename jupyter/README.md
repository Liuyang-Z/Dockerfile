# Jupyter

Jupyter in docker.

## How tho run?

```
docker run -d -v /notebook:/data/jupyternb -p 8888:8888 --name jupyter yangzl/jupyter:latest
```

The default password is `hello`