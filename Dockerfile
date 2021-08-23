FROM ubuntu:latest

USER 0
SHELL ["/bin/bash", "-c"]

## preesed tzdata, update package index, upgrade packages and install needed software
RUN truncate -s0 /tmp/preseed.cfg && \
    (echo "tzdata tzdata/Areas select America" >> /tmp/preseed.cfg) && \
    (echo "tzdata tzdata/Zones/America select New_York" >> /tmp/preseed.cfg) && \
    debconf-set-selections /tmp/preseed.cfg && \
    rm -f /etc/timezone /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    apt-get install -y tzdata
## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
    apt-get install -y jq git curl wget rsync xz-utils unzip zip libxml2 libc++abi-dev

WORKDIR /build
COPY build-tweaked-app.sh .
RUN chmod a+x build-tweaked-app.sh && \
    mkdir /debs && \
    chmod 777 /debs && \
    git clone https://github.com/Al4ise/Azule && \
    source Azule/azule-functions\
    ./build-tweaked-app.sh

VOLUME [ "/debs" ]

CMD ./build-tweaked-app.sh