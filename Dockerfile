FROM debian:bookworm
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX15.1.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout 29fe6dd35522073c9df5800f8cd1feb4b9a993a8 \
 && mv /MacOSX15.1.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
