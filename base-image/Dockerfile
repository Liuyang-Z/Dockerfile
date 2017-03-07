FROM ubuntu:16.04
MAINTAINER Liuyang-Z "zlyang65@gmail.com"

RUN set -x \
        && sed -Ei 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc \
        && \cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && sed -Ei '$a TZ="Asia\/Shanghai\"; export TZ' /root/.bashrc \
        && mv /etc/apt/sources.list /etc/apt/sources.list.backup

COPY autoRun.sh /autoRun.sh
COPY sources.list /etc/apt/sources.list
RUN chmod a+x /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]