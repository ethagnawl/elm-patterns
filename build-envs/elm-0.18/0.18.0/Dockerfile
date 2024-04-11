FROM node:21-bookworm-slim

RUN apt-get update
RUN apt-get install -y \
  curl

RUN npm install --global elm-live@2.7.5

RUN curl -L -o elm.tar.gz https://github.com/ethagnawl/elm-old-binaries/releases/download/2024-04-10/0.18.0-linux-x64.tar.gz

RUN tar -xzf elm.tar.gz
RUN chmod +x dist_binaries/*
RUN mv dist_binaries/* /usr/local/bin/

# No idea why this is required for _some_ apps to be able to pull deps but not
# others ...
# See: https://github.com/cuducos/my-internet-speed/issues/10
RUN echo "tcp 6	TCP # transmission control protocol" > /etc/protocols

CMD elm --help
