FROM debian:bookworm
LABEL maintainer="Florian Zwoch <fzwoch@gmail.com>"

COPY MacOSX14.0.sdk.tar.xz /

RUN apt update \
 && apt install -y git cmake libxml2-dev libssl-dev libz-dev clang llvm xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 && cd osxcross \
 && git checkout 5e1b71fcceb23952f3229995edca1b6231525b5b \
 && mv /MacOSX14.0.sdk.tar.xz tarballs \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
