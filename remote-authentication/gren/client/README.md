# Remote Authentication Client

## Overview

This is an example which shows how you'd authenticate against a remote API from
within an Elm application. It might be a stretch to call this one a UI pattern,
but it's _close enough_. I know I would have found a similar, functional
example useful when attempting to do something similar for the first time.

Note that the current version of the application does not do any serious input
validation. Turns out this is an Elm/Gren pattern of its own and is something
I'll come back to.

The main aims of this demo were to show how you'd:
- [encode some/all of a model](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L80-L95)
- [send it over the wire](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L98-L129)
- [decode the response and integrate it into your application state](https://github.com/ethagnawl/elm-ui-patterns/blob/master/remote-authentication/Update.elm#L11-L77)
## Demo
- https://pdoherty-demos.s3.us-east-1.amazonaws.com/remote-authentication/gren/index.html

## Running the example
### Client:
- `npm install --global gren` (if you haven't already)
- `make serve`

The client assumes the API is running on http://localhost:3000 but that can be modified (via `flags.apiRoot`) in index.html as you see fit.

### Server:
See the README in remote-authentication/gren/server/README.md
