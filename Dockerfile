FROM debian:bullseye
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX13.0.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout 50e86ebca7d14372febd0af8cd098705049161b9 \
 && mv /MacOSX13.0.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
