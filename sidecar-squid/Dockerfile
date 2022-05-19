FROM alpine:3.10.3
LABEL maintainer "Ariel A. Vasquez - https://gitlab.com/arich.net"

RUN    cd /tmp \
    && apk add --no-cache --virtual .build-deps \
          ca-certificates \
          build-base \
          linux-headers \
          perl \
    && wget http://www.squid-cache.org/Versions/v4/squid-4.15.tar.gz \
    && tar -zxvf squid-4.15.tar.gz \
    && cd squid-4.15 \
    && ./configure \
           --disable-icap-client \
           --disable-wccp \
           --disable-wccpv2 \
           --disable-select \
           --disable-poll \
           --disable-kqueue \
           --disable-epoll \
           --disable-devpoll \
           --disable-ident-lookups \
           --disable-unlinkd \
           --disable-ipv6
