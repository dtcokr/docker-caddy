# docker-caddy
Run caddy in docker, build from [source](https://github.com/caddyserver/caddy), add plugin from source. Agree to [Let's Encrypt Subscriber Agreement](https://letsencrypt.org/documents/2017.11.15-LE-SA-v1.2.pdf) by **DEFAULT**. Otherwise, modify the Dockerfile.

### Plugins
This image includes [ipfilter](https://caddyserver.com/docs/http.ipfilter), [git](https://caddyserver.com/docs/http.git), [nobots](https://caddyserver.com/docs/http.nobots), [realip](https://caddyserver.com/docs/http.realip) and [caddy-docker-proxy](github.com/lucaslorentz/caddy-docker-proxy) plugins.
Plugins can be configured via the [plugin.go](https://github.com/dtcokr/docker-caddy/blob/drafts/plugin.go) file in the repository.

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
See [GitHub](github.com/lucaslorentz/caddy-docker-proxy)
