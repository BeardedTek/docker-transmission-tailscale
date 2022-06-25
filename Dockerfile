FROM linuxserver/transmission as build

RUN apk --no-cache add nano tailscale py3-netifaces rpcbind && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    wget -O /usr/bin/getnetwork https://raw.githubusercontent.com/BeardedTek-com/tailscale/main/rootfs/usr/bin/getnetwork && \
    sed -i 's/venv/usr/' /usr/bin/getnetwork && \
    chmod +x /usr/bin/getnetwork

COPY root /

FROM scratch
COPY --from=build / /
ENTRYPOINT ["/init"]