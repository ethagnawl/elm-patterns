.DEFAULT_GOAL := default

.PHONY: default
default: 
	gren make Main --output=./output/gren.exe

# usage: PORT=80 make serve
.PHONY: serve
serve:  default
	node ./output/gren.exe $${PORT:-3000}

.PHONY: watch 
watch: default
	ls src/*.gren | entr -r make serve
