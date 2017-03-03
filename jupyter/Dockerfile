FROM yangzl/base-image:latest
MAINTAINER YANG-ZL "zlyang65@gmail.com"

RUN buildDeps='python-dev python-pip python3-dev python3-pip'; \
    set -x \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && pip install --upgrade pip \
        && pip install jupyter \
        && python3 -m pip install ipykernel \
        && python3 -m ipykernel install --user \
        && apt-get clean \
        && jupyter notebook --generate-config \
        && rm -rf /root/.jupyter/jupyter_notebook_config.py \
        && mkdir -p /data/jupyternb

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN set -x \
        && sed -Ei '2a jupyter notebook >> /var/log/jupyter.log 2>&1' /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
