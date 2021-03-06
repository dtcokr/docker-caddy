# docker-caddy
![Docker Pulls](https://img.shields.io/docker/pulls/dtcokr/caddy)
[![](https://images.microbadger.com/badges/image/dtcokr/caddy.svg)](https://microbadger.com/images/dtcokr/caddy "Get your own image badge on microbadger.com")
![GitHub last commit](https://img.shields.io/github/last-commit/dtcokr/docker-caddy)

Run caddy in docker, build from [source](https://github.com/caddyserver/caddy), add plugin from source. Agree to [Let's Encrypt Subscriber Agreement](https://letsencrypt.org/documents/2017.11.15-LE-SA-v1.2.pdf) by **DEFAULT**. Otherwise, modify the Dockerfile.

### Plugins
This image includes [caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) plugin.
Plugins can be configured via the [plugin.go](https://github.com/dtcokr/docker-caddy/blob/master/plugin.go) file in the repository.

## Usage
```sh
$ docker run -d -p 2015:2015 dtcokr/caddy
```
Go to `http://127.0.0.1:2015` to check if Caddy is running. If running remotely, go to `http://remote_ip:2015`. 

### Saving Certificates
Default certificates location `/root/.caddy`
```sh
$ docker run -d \
    -v $PWD/Caddyfile:/etc/Caddyfile \
    -v $HOME/.caddy:/root/.caddy \
    -p 80:80 \
    -p 443:443 \
    dtcokr/caddy
```

### Mount sites root
Caddyfile: `/etc/Caddyfile`

Sites root: `/www`

```sh
$ docker run -d \
    -v /path/to/Caddyfile:/etc/Caddyfile \
    -v /path/to/sites/root:/www
    -p 80:80 \
    dtcokr/caddy
```

### With Let's Encrypt SSL
Add a vaild domain and email to your Caddyfile.
```sh
yourdomain.com
tls address@domain.com
```
Run:
```sh
$ docker run -d \
    -v /path/to/Caddyfile:/etc/Caddyfile \
    -v $HOME/.caddy:/root/.caddy \
    -v /path/to/sites/root:/www \
    -p 80:80 \
    -p 443:443 \
    dtcokr/caddy
```
### Caddy-docker-proxy usage
See [Caddy-docker-proxy(GitHub)](https://github.com/lucaslorentz/caddy-docker-proxy)

`docker-compose.yml` example: 
use `labels` to generate Caddyfile

```
version: "3"
services:
  caddy:
    images: dtcokr/caddy
    ports:
      - "80:80"
      - "443:443"
      - "2015:2015"
    networks:
      - caddy
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "/www:/www"
    restart: always
    labels:
      caddy: ":2015"
      caddy.root: "/www"
networks:
  caddy:
```
