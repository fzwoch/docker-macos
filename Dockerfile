FROM debian:buster
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX11.1.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout 4287300a5c96397a2ee9ab3942e66578a1982031 \
 && mv /MacOSX11.1.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
