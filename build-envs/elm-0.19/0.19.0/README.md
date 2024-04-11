# 0.19.0

# Usage
```
docker build -t elm-0.19.0 .

# static build
docker run --rm -v /path/to/directory:/build -w /build elm-0.19.0 elm make src/Main.elm --output=elm.js

# elm-live
docker run -p 8000:8000 --rm -it -v /path/to/directory:/build -w /build elm-0.19.0 elm-live --host=0.0.0.0 src/Main.elm -- --output=elm.js
```

## Gotchas
- Elm files must be in src directory for elm-live to work. Its docs claim it'll
recognize changes to any *elm files in the CWD and its children but this does
not appear to work. See: https://github.com/wking-io/elm-live/issues/250
- If you encounter errors referencing corrupt binaries and the following directories:
    - /root/.elm
    - elm-stuff
You'll probably need to delete the local elm-stuff directory from your source
directory (if you've ever built the project locally and the artifacts remain)
or use the container interactively and first remove or otherwise exclude that
directory.
