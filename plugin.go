package main

import (
		"github.com/caddyserver/caddy/caddy/caddymain"

		// plug in plugins here, for example:
		// _ "import/path/here"

		// caddy-docker-proxy
		_ "github.com/lucaslorentz/caddy-docker-proxy/tree/v0/plugin"
)

func main() {
		caddymain.EnableTelemetry = false
		caddymain.Run()
}
