FROM node:21-bookworm-slim

RUN apt-get update
RUN apt-get install -y \
  curl

RUN curl -L -o elm.tar.gz https://github.com/ethagnawl/elm-old-binaries/releases/download/2024-04-10/0.19.0-linux-x64.tar.gz?wtf

RUN tar -xzf elm.tar.gz
RUN chmod +x 0.19.0-linux-x64
RUN mv 0.19.0-linux-x64 /usr/local/bin/elm

CMD elm --help
