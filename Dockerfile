FROM node:latest

ENV TERM=xterm DEBIAN_FRONTEND=noninteractive

RUN npm install -g casperjs phantomcss phantomjs slimerjs resemblejs && apt-get update && \
  cd / && \
  apt-get -qqy install curl fontconfig ca-certificates && \
  rm -rf ~/.npm && npm cache clear && \
  rm -rf /var/lib/apt/lists/*
