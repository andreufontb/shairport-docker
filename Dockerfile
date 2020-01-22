FROM alpine:latest AS build-stage
RUN apk -U add 

RUN apk -U add \
        git \
        build-base \
        autoconf \
        automake \
        libtool \
        alsa-lib-dev \
        libdaemon-dev \
        popt-dev \
        libressl-dev \
        soxr-dev \
        avahi-dev \
        libconfig-dev
RUN cd /root \
    && git clone https://github.com/mikebrady/shairport-sync.git \
    && cd shairport-sync \
    && autoreconf -i -f \
    && ./configure \
        --with-alsa \
        --with-pipe \
        --with-avahi \
        --with-ssl=openssl \
        --with-soxr \
    && make \
    && make install \
    && cd /

FROM alpine:latest AS package-stage
RUN apk add \
        dbus \
        alsa-lib \
        libdaemon \
        popt \
        libressl \
        soxr \
        avahi \
        libconfig \
    && rm -rf \
        /etc/ssl \
        /var/cache/apk/* \
        /lib/apk/db/* \
        /root/shairport-sync

COPY --from=build-stage /usr/local/bin/shairport-sync /usr/local/bin/shairport-sync
COPY --from=build-stage /usr/local/etc/ /usr/local/etc/

COPY start.sh /start

RUN chmod +x /start

ENV AIRPLAY_NAME Docker

ENTRYPOINT [ "/start" ]