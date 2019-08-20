#Build
FROM golang:1.12.9-alpine as builder

ENV GO111MODULE=on

RUN apk add --no-cache --update git \
  && mkdir caddy

COPY plugin.go /go/caddy

RUN cd caddy \
  && go mod init caddy \
  && go get github.com/caddyserver/caddy/caddy \
  && go build

#Run
FROM alpine:latest

ENV ACME_AGREE="true"

COPY --from=builder /go/caddy/caddy /usr/bin/caddy

RUN /usr/bin/caddy -version \
  && /usr/bin/caddy -plugins

EXPOSE 80 443
VOLUME /root/.caddy /var/www/wwwroot
WORKDIR /var/www/wwwroot

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["-conf", "/etc/Caddyfile", "-log", "stdout", "-agree", "$ACME_AGREE"]
