FROM node:21-bookworm-slim

RUN apt-get update
RUN apt-get install -y \
  curl

RUN curl -L -o elm.tar.gz https://github.com/ethagnawl/elm-old-binaries/releases/download/2024-04-10/0.19.1-linux-x64.tar.gz
RUN npm install -g elm-live@4.0.2

RUN tar -xzf elm.tar.gz
RUN mv ./0.19.1-linux-x64/0.19.1-linux-x64 ./elm
RUN chmod +x elm
RUN mv elm /usr/local/bin/elm

CMD elm --help
