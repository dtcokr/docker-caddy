#
# Build
#
FROM golang:1.12.9-alpine as builder

ENV GO111MODULE=on

RUN apk add --no-cache --update git 

COPY plugin.go /go/caddy/plugin.go

RUN cd caddy \
  && go mod init caddy \
  && go get github.com/caddyserver/caddy \
  && go build

#
# Install
#
FROM alpine:3.10

LABEL maintainer="dtcokr <dtcokr@outlook.com>" \
  org.label-schema.vcs-url="https://github.com/dtcokr/docker-caddy"


COPY --from=builder /go/caddy/caddy /usr/bin/caddy

RUN apk add --update --no-cache ca-certificates \
  && rm -rf /var/cache/apk/* \
  && /usr/bin/caddy -version \
  && /usr/bin/caddy -plugins

EXPOSE 80 443 2015
VOLUME /root/.caddy /www
WORKDIR /www

COPY index.html /www/index.html

ENTRYPOINT ["caddy"]
CMD ["-log", "stdout", "-agree"]
