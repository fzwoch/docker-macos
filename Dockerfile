FROM debian:buster
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX10.11.sdk.tar.xz /

RUN apt update \
 && apt install -y git make clang \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout ee54d9fd43b45947ee74c99282b360cd27a8f1cb \
 && mv /MacOSX10.11.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
