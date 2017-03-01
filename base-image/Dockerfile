FROM ubuntu:latest
MAINTAINER YANG-ZL "zlyang65@gmail.com"

# update
#RUN set -x \
#        &&apt-get update \
#        && apt-get install -y vim \
#        && apt-get clean

# edit the .bashrc file
RUN set -x \
        && sed -Ei 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc \
        && \cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && sed -Ei '$a TZ="Asia\/Shanghai\"; export TZ' /root/.bashrc

COPY autoRun.sh /autoRun.sh
RUN chmod a+x /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]