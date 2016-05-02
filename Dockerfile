FROM node:latest

ENV TERM=xterm DEBIAN_FRONTEND=noninteractive PHANTOM_VERSION=2.1.1 SLIMER_VERSION=0.9.6

RUN npm install -g casperjs && apt-get update && \
  cd / && \
  apt-get -qqy install curl fontconfig ca-certificates && \
  curl https://slimerjs.org/slimerjs-pubkey.gpg | gpg --import && \
  curl -L -s -o "slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2.asc" "http://download.slimerjs.org/releases/${SLIMER_VERSION}/slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2.asc" && \
  gpg --verify-files *.asc && \
  curl -o "slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2" "http://download.slimerjs.org/releases/${SLIMER_VERSION}/slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2" && \
  sha256sum -c *.asc && \
  tar vxjf "slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2" && \
  rm -rf "slimerjs-${SLIMER_VERSION}-linux-x86_64.tar.bz2" && \
  curl -L -k -s -o "phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2" "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2" && \
  tar xjvf "phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2" && \
  rm -rf "phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2" && \
  ln -s "/slimerjs-${SLIMER_VERSION}/slimerjs" /usr/local/bin/slimerjs && \
  ln -s "/phantomjs-${PHANTOM_VERSION}-linux-x86_64/bin/phantomjs" /usr/local/bin/phantomjs && \
  rm -rf ~/.npm && npm cache clear && \
  rm -rf /var/lib/apt/lists/*
