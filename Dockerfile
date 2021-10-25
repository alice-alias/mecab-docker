FROM node:16-alpine

RUN apk add --no-cache \
    libstdc++

COPY --from=ghcr.io/alice-alias/mecab-docker/base /usr/local/bin /usr/local/bin
COPY --from=ghcr.io/alice-alias/mecab-docker/base /usr/local/etc /usr/local/etc
COPY --from=ghcr.io/alice-alias/mecab-docker/base /usr/local/lib /usr/local/lib
COPY --from=ghcr.io/alice-alias/mecab-docker/base /usr/local/libexec /usr/local/libexec
