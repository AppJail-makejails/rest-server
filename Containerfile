ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE} AS builder

ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="Rest Server" \
    org.opencontainers.image.description="Rest Server is a high performance HTTP server that implements restic's REST backend API" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/rest-server" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/rest-server" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install -U rest-server apache24; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

ENV DATA_DIRECTORY /data
ENV PASSWORD_FILE /data/.htpasswd

COPY scripts/create_user /usr/local/bin/create_user
COPY scripts/delete_user /usr/local/bin/delete_user
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

VOLUME ["/data"]
EXPOSE 8080

CMD ["/entrypoint.sh"]
