FROM yangzl/base-image:latest
MAINTAINER Liuyang-Z "zlyang65@gmail.com"

ADD https://download-cdn.resilio.com/2.4.4/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN set -x \
        && tar -xf /tmp/sync.tgz -C /usr/bin rslsync \
        && rm -f /tmp/sync.tgz \
        && mkdir -p /data/sync /data/config

COPY sync.conf /etc/sync.conf
RUN set -x \
        && sed -Ei '2a /usr/bin/rslsync --nodaemon --config /etc/sync.conf' /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
