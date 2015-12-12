FROM ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>
ENV DEBIAN_FRONTEND noninteractive

ENV NDK_ROOT /installs/android-ndk-r9d
ENV PATH /installs/android-toolchain/bin:${NDK_ROOT}:$PATH
ENV PATH ${NDK_ROOT}:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV ANDROID_NDK_HOME ${NDK_ROOT}

ADD dependencies-linux.sh /installs/dependencies-linux.sh
ADD setenv.sh /installs/setenv.sh
ADD build.sh /installs/build.sh

WORKDIR /installs
RUN ./dependencies-linux.sh
RUN ./build.sh
