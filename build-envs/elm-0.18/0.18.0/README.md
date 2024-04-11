# 0.18.0

## Usage
```
docker build -t elm-0.18.0 .

# static build
docker run --rm -v /path/to/source:/build -w /build elm-0.18.0 elm-make Main.elm --output=elm.js

# elm-live
docker run -p 8000:8000 --rm -it -v ~/projects/elm-ui-patterns/spa-routing/:/build -w /build elm-0.18.0 elm-live --host=0.0.0.0 Main.elm -- --output=elm.js
```
