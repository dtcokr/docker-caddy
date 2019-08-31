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
FROM alpine:latest
LABEL maintainer "dtcokr <dtcokr@outlook.com>"

COPY --from=builder /go/caddy/caddy /usr/bin/caddy

RUN /usr/bin/caddy -version \
  && /usr/bin/caddy -plugins

EXPOSE 80 443 2015
VOLUME /root/.caddy /www
WORKDIR /www

COPY index.html /www/index.html

ENTRYPOINT ["caddy"]
CMD ["-log", "stdout", "-agree"]
