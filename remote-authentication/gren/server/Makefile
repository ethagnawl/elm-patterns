.DEFAULT_GOAL := default

.PHONY: default
default: 
	gren make Main --output=./output/gren.exe

.PHONY: serve
serve:  default
	node ./output/gren.exe

.PHONY: watch 
watch: default
	ls src/*.gren | entr -r make serve
