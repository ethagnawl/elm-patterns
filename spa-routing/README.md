# SPA Routing

This is an example which shows how you'd add SPA-style routing to an Elm
application.

This example shows a list of albums, whose detailed information is revealed
when an individual album is clicked. The hash changes to reflect the current
album and allows for users to share links to individual albums.

This example uses hash-routing, but you could also use `pushState` - assuming
your host/back-end recognizes the nested URLs.

Kudos to @simon-larson, whose [Elm SPA Template](http://github.com:simon-larsson/elm-spa-template.git) was the basis for this
example.

## Demo
- https://ellie-app.com/h47h7m3WNa1/1
- https://s3.amazonaws.com/pdoherty-demos/spa-routing/index.html

## Running the example:
- `npm install --global elm elm-live` (if you haven't already)
- `elm-live Main.elm --output=elm.js --open`
