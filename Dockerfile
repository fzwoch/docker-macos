FROM debian:stretch
MAINTAINER Florian Zwoch <fzwoch@gmail.com>

RUN apt update
RUN apt install -y git make clang

RUN cd /opt \
 && git clone https://github.com/tpoechtrager/osxcross.git \
 &&	cd osxcross \
 && git checkout 1a1733a773fe26e7b6c93b16fbf9341f22fac831

COPY MacOSX10.11.sdk.tar.xz /opt/osxcross/tarballs/MacOSX10.11.sdk.tar.xz

RUN cd /opt/osxcross \
 && PORTABLE=1 UNATTENDED=1 ./build.sh

ENV PATH $PATH:/opt/osxcross/target/bin
