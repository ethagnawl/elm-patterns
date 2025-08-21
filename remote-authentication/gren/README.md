# Remote Authentication

## Overview

This is an example which shows how you'd authenticate against a remote API from
within an Elm application. It might be a stretch to call this one a UI pattern,
but it's _close enough_. I know I would have found a similar, functional
example useful when attempting to do something similar for the first time.

The main aims of this demo were to show how you'd:
- [encode some/all of a model](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L80-L95)
- [send it over the wire](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L98-L129)
- [decode the response and integrate it into your application state](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L11-L77)

This application purposely doesn't use any external packages, but I think using
elm-decode-pipeline, json-extra, elm-http-builder, etc. could greatly simplify
the application code.

## Demo
- https://s3.amazonaws.com/pdoherty-demos/remote-authentication/index.html

## Running the example
### Elm
- `npm install --global elm elm-live` (if you haven't already)
- `elm-live src/Main.elm --output=elm.js --open`
### API
- You've got a few options here:
    - If you're on an x86-64 machine, you should be able to download/run the
    remote-authentication-api application binary from:
    https://github.com/ethagnawl/remote-authentication-demo-api/blob/master/remote-auth-api
    - clone the [remote-authentication-api repository](https://github.com/ethagnawl/remote-authentication-demo-api) and build/run
    the binary using the provided instructions

## Resources:
- http://package.elm-lang.org/packages/evancz/elm-http/3.0.0/Http
- http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Decode
- http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Encode
- https://www.reddit.com/r/elm/comments/72cluw/easy_questions_beginners_thread_week_of_20170925/
- https://github.com/rtfeldman/elm-spa-example/blob/master/src/Page/Login.elm#L98
- https://www.muicss.com/
