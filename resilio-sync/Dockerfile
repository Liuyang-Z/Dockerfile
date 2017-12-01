FROM yangzl/base-image:latest
LABEL maintainer="liuyang.z@hooowl.com"

ADD https://download-cdn.resilio.com/2.4.4/linux-x64/resilio-sync_x64.tar.gz /tmp/sync.tgz
RUN set -x \
        && tar -xf /tmp/sync.tgz -C /usr/bin rslsync \
        && rm -f /tmp/sync.tgz \
        && mkdir -p /data/resilio/sync /data/resilio/config

COPY sync.conf /etc/sync.conf.default
COPY autoRun.sh /autoRun.sh
RUN set -x \
        && chmod a+x /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
