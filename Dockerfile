FROM golang:1.14-alpine3.11 AS builder

ARG COMMIT

RUN apk add --no-cache git
RUN go get -u github.com/caddyserver/xcaddy/cmd/xcaddy \
  && xcaddy build ${COMMIT} --output /tmp/caddy

FROM alpine:3.11

ARG COMMIT

ENV CADDY_VERSION=v2.0.0-${COMMIT}

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

VOLUME /config
VOLUME /data

LABEL org.opencontainers.image.version=v2.0.0-${COMMIT}
LABEL org.opencontainers.image.title=Caddy
LABEL org.opencontainers.image.description="a powerful, enterprise-ready, open source web server with automatic HTTPS written in Go"
LABEL org.opencontainers.image.url=https://caddyserver.com
LABEL org.opencontainers.image.documentation=https://caddyserver.com/docs
LABEL org.opencontainers.image.vendor="Light Code Labs"
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.source="https://github.com/ggicci/caddy-docker"

EXPOSE 80
EXPOSE 443
EXPOSE 2019

COPY --from=builder /tmp/caddy /usr/bin/caddy

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
