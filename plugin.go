package main

import (
		"github.com/caddyserver/caddy/caddy/caddymain"

		// plug in plugins here, for example:
		// _ "import/path/here"

		// http.ipfilter
		_ "github.com/pyed/ipfilter"
		// http.git
		_ "github.com/abiosoft/caddy-git"
		// http.nobots
		_ "github.com/Xumeiquer/nobots"
		// http.realip
		_ "github.com/captncraig/caddy-realip"
)

func main() {
		caddymain.EnableTelemetry = false
		caddymain.Run()
}
