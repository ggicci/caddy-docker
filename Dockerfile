FROM golang:1.14-alpine3.11 AS builder

RUN apk add --no-cache git
RUN go get -u github.com/caddyserver/xcaddy/cmd/xcaddy \
  && xcaddy build 68cebb28d063a7a71705ce022f118b5e1205fa3f --output /tmp/caddy

FROM alpine:3.11

ENV CADDY_VERSION=v2.0.0-68cebb28d063a7a71705ce022f118b5e1205fa3f

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

VOLUME /config
VOLUME /data

LABEL org.opencontainers.image.version=v2.0.0-68cebb28
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
