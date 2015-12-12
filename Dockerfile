FROM ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /installs
ADD dependencies-linux.sh /installs/dependencies-linux.sh
ADD setenv.sh /installs/setenv.sh
RUN ./dependencies-linux.sh

#ADD build.sh /installs/build.sh
ADD . /installs/kalium-jni
WORKDIR /installs/kalium-jni
RUN ./build.sh

#ADD build-kaliumjni.sh /installs/build-kaliumjni.sh
RUN ./build-kaliumjni.sh
