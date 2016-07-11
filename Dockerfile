#
# Dockerfile for kcptun-server
#

FROM golang:latest
MAINTAINER vmlinz <vmlinz@gmail.com>

ENV KCPTUN_VER 20160701
ENV KCPTUN_URL https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VER}/kcptun-linux-amd64-${KCPTUN_VER}.tar.gz
ENV KCPTUN_DIR kcptun-linux-amd64-$SS_VER

WORKDIR /tmp/

RUN set -ex \
    && curl -sSL $KCPTUN_URL | tar xz \
    && cd $KCPTUN_DIR \
    && chmod +x ./* \
    && mv ./* /usr/local/bin \
    && cd .. \
    && rm -fr $KCPTUN_DIR

ENV TARGET_ADDR 127.0.0.1
ENV TARGET_PORT 38080
ENV LISTEN_ADDR 0.0.0.0
ENV LISTEN_PORT 38081
ENV MODE fast2
ENV CRYPT aes
ENV KEY ^password$
ENV CONN 4
ENV MTU 1400
ENV SNDWND 2048
ENV RCVWND 2048

EXPOSE $LISTEN_PORT/udp

CMD server_linux_amd64 -l $LISTEN_ADDR:$LISTEN_PORT \
                       -t $TARGET_ADDR:$TARGET_PORT \
                       --key $KEY \
                       --crypt $CRYPT \
                       --mode $MODE \
                       --mtu $MTU \
                       --sndwnd $SNDWND \
                       --rcvwnd $RCVWND
