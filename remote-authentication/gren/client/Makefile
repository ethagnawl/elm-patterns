.DEFAULT_GOAL := default

.PHONY: default
default:
	gren make Main --output=./output/gren.js

# usage: PORT=80 make serve
.PHONY: serve
serve:  default
	python3 -m http.server $${PORT:-3000}
