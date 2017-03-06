FROM yangzl/base-image:latest
MAINTAINER Liuyang-Z "zlyang65@gmail.com"

RUN set -x \
    && apt-get update \
    && apt-get install -y wget \
    && echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" >> /etc/apt/sources.list \
    && wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y resilio-sync \
    && mkdir -p /data/sync \
    && chown -R rslsync:rslsync /data

COPY config.json /etc/resilio-sync/config.json
RUN set -x \
        && sed -Ei '2a /etc/init.d/resilio-sync start' /autoRun.sh
ENTRYPOINT ["/autoRun.sh"]

CMD ["/bin/bash"]
