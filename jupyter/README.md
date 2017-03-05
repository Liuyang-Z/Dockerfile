# Jupyter

Jupyter Notebook(JN) in docker. Default kernel is python3.

## Run Docker

_Docker Run Command_
```bash
# docker run -d -v /notebook:/data/jupyternb -p 8888:8888 --name jupyter yangzl/jupyter:latest
```

* `-v /notebook:/data/jupyternb` 其中 `:` 的前半部分为主机要与容器共享的文件夹，用户可以自定义，起后半部分为容器内文件夹，不可以改变。
* `-p 8888:8888` 为主机端口到容器端口的映射。

默认密码为： `hello`

## Change the default password

* 新建 Python3 notebook
* 在单元中输入 `from notebook.auth import passwd; passwd()` 根据提示输入密码，并会生成 `'sha1:1*****'` 密码串。
* 复制并替换密码串到 `/root/.jupyter/jupyter_notebook_config.py` 的 `c.NotebookApp.password = u''`中。
* 保存，重启容器。


## Install JN kernels
由于有些内核的安装会占用较大的存储空间，如果默认内置常用的内核会使得容器体积过大。但是，我已经将一些常用的 JN 内核的安装脚本内置到了容器中，如果您需要可以通过简单的命令进行安装。

已经包含的安装脚本如下：
* c
* python2
* R

如果您需要安装其它的内核，在这 [Jupyter-kernels][1] 可以查看其支持的所有内核。

*安装步骤*
- 在 JN 中新建 Terminal
- 进入 `/data/Scripts/`
- 输入命令 `$ bash xx.sh` 即可以安装 xx 内核。

## TODO
* 生成 PDF 文件
* 支持 Golang

## FAQ
如果使用过程中有任何问题或出现致命错误，请尽可能详细的截图并 email( zlyang65#gmail.com )，非常感谢。

[1]: https://github.com/jupyter/jupyter/wiki/Jupyter-kernels