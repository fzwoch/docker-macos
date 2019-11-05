FROM debian:buster
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX10.14.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout 98149255feea67f3d01538007fe4f2b53c45ffb8 \
 && mv /MacOSX10.14.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
