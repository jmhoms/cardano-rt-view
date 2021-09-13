FROM alpine:latest as builder

ARG VER=0.3.0
ARG URL=https://github.com/input-output-hk/cardano-rt-view/releases/download/${VER}/cardano-rt-view-${VER}-linux-x86_64.tar.gz

RUN apk add --update curl && \
    mkdir -p /opt/cardano-rt-view && \
    cd /opt/cardano-rt-view && \
    curl -L ${URL} | tar zxvf -

FROM busybox
COPY --from=builder /opt/ /opt/
EXPOSE 8024 
WORKDIR /opt/cardano-rt-view
CMD /opt/cardano-rt-view/cardano-rt-view --config /data/config/cardano-rt-view.json
