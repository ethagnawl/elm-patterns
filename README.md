# Elm UI Patterns

This repository collects a number of UI and application patterns I've discovered while building
Elm applications. These patterns are things that -- to my mind -- are simple/straightforward
in JavaScript but may not have immediately obvious solutions in Elm.

Pull requests containing improvements and new examples would be most appreciated.

## Demos
- [Creepy Spyware](https://s3.amazonaws.com/pdoherty-demos/creepy-spyware-demo/index.html)
- [Decaying Class Name](https://ellie-app.com/38HQZnWLQFna1)
- [Normalized Form Input](https://ellie-app.com/3sTMvVDBKYRa1)
- [Remote Authentication](https://s3.amazonaws.com/pdoherty-demos/remote-authentication/index.html)
- [SPA Routing](https://s3.amazonaws.com/pdoherty-demos/spa-routing/index.html)
- [Sync CSS Transition and State Change](https://ellie-app.com/3wTR8tFFjL3a1)
- [Video Player](https://s3.amazonaws.com/pdoherty-demos/elm-video-player/index.html)

## Build Containers
There are a few Docker containers in the build-envs directory which can be used to build/run the examples in this collection.  The Dockerfiles use a Node 21 base image and my [fork](https://github.com/ethagnawl/elm-old-binaries) of the [elm-old-binaries](https://github.com/lydell/elm-old-binaries) repository to download the Elm binaries.

See the individual READMEs for usage instructions.

NOTE: These containers are not project-specific and can be used by anyone looking to build Elm projects in a sandboxed environment. This is especially helpful with older versions of Elm which can be tricky to locate and install.

## TODO
- port older apps to 0.19
- rework SPA routing to use 0.19 feature set
- animation example
