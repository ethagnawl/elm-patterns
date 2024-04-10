# 0.18.0

## Usage
```
docker build -t elm-0.18.0 .
docker run --rm -v /path/to/source:/build -w /build elm-0.18.0 elm-make Main.elm --output=elm.js
```
