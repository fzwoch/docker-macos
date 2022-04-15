FROM debian:bullseye
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX12.3.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout be2b79f444aa0b43b8695a4fb7b920bf49ecc01c \
 && mv /MacOSX12.3.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
