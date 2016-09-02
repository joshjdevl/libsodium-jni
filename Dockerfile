FROM ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -y -qq install sudo
WORKDIR /installs/libsodium-jni
ADD . /installs/libsodium-jni
ADD settings.xml ~/.m2/settings.xml

RUN ./build-linux.sh
