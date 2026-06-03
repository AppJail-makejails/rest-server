ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/base:${FREEBSD_RELEASE} AS builder

LABEL org.opencontainers.image.title="Rest Server" \
    org.opencontainers.image.description="Rest Server is a high performance HTTP server that implements restic's REST backend API" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/rest-server" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/rest-server" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN pkg update && \
    pkg install -U FreeBSD-utilities && \
    pkg install -U rest-server apache24
