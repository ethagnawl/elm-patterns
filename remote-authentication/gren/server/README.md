# Remote Authentication Server

## Overview

This is an example BE/API/server application written using Gren. It's
a port of the [remote-authentication-demo-api](https://github.com/ethagnawl/remote-authentication-demo-api) to Gren.

This was my first foray into server-side Gren and TEA on the server. Overall,
it was a great experience. That's not to say there weren't hiccups, though.

In particular, I found the common need to hash an incoming value to be very
tedious. I know _why_ this is the case -- it uses the Node Web Cryptography API,
which requires a `Task` to retrieve a `SecureContext` -- and _this is_ a very
sensible and practical design decision. However, I found getting it working in
concert with TEA was not for the faint of heart -- especially in comparison
with the Crystal equivalent in the original API used by the Elm version. I'm
still not entirely happy with how my program needed to be modified to handle
hashing strings but maybe I'll come back to that some day.

Even in its current state, however, I think this example is very valuable to the
Gren community because I couldn't find any documentation, tutorials or FLOSS
projects which provide a working example of what is a very common use case.

To be very clear, none of the above is a knock on the Gren maintainers or the
community. I might even be overreacting and others may find the Crypto workflow
perfectly sensible but, _I_ do think there's room for improvement, if only on
the documentation side of the fence. Though, I don't see a practical reason why
the Crypto library couldn't be ported to pure Gren and drop the Web Crypto API
requirement but I'm admittedly getting out of my depth here.

I also noticed that the HTTP OPTION verb is not included in the
`Http.Request.method` enum and I think it should be, as its very common in HTTP
APIs serving JS-based clients -- like Gren applications! I will open a ticket
about this in the relevant Gren repository and will maybe see about opening a
PR to add it, too.

The main aims of this demo were to show how you'd:
- run a server-side Gren application
- dynamically assign a port using `Node.Environment`
- handle HTTP requests
- configure CORS for JS/web clients
- hash a password (naively; still need to salt)

This was also a good excuse to try my hand at creating a Gren package! As part
of the hashing workflow, I found myself needing a function that would convert
bytes to a hex-encoded string. So, I wrote my own, made a [GH repository](https://github.com/ethagnawl/gren-bytes-utils) for it
and was able to pull it into this project and use it without issue. There's a
case to be made for adding this function to the Bytes module and there's even an
open ticket for this but, for now, I hope people find my package helpful.

The hashing workflow also neccesitated a common bit of functionality which
is currently missing from the Gren stlib

## Demo
- https://pdoherty-demos.s3.us-east-1.amazonaws.com/remote-authentication/gren/index.html

## Running the example
### Server:
- `npm install --global gren` (if you haven't already)
- `[PORT=3000] make serve`

### Client:
See the README in remote-authentication/gren/client/README.md
