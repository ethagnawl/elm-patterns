# 0.19.0

# Usage
```
docker build -t elm-0.19.0 .
docker run --rm -v /path/to/directory:/build -w /build elm-0.19.0 elm make Main.elm --output=elm.js
```

## Gotchas
- If you encounter errors referencing corrupt binaries and the following directories:
    - /root/.elm
    - elm-stuff
You'll probably need to delete the local elm-stuff directory from your source
directory (if you've ever built the project locally and the artifacts remain)
or use the container interactively and first remove or otherwise exclude that
directory.
