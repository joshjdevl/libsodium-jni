FROM ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>
ENV DEBIAN_FRONTEND noninteractive

ENV NDK_ROOT /installs/android-ndk-r9d
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN apt-get update && apt-get -y install python-software-properties software-properties-common
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN apt-get update

RUN add-apt-repository ppa:apt-fast/stable
RUN apt-get update
RUN apt-get -y install apt-fast

RUN apt-fast update
RUN apt-fast install -y wget git autoconf autoconf automake build-essential autogen libtool gettext-base gettext vim bzip2 libpcre3-dev  libpcre++-dev

RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-fast update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-fast install -y oracle-java7-installer maven

RUN mkdir /installs
RUN cd /installs && wget --quiet https://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
RUN cd /installs && tar -xf android-ndk-r9d-linux-x86_64.tar.bz2

ENV PATH /installs/android-toolchain/bin:${NDK_ROOT}:$PATH
RUN  ${NDK_ROOT}/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=/installs/android-toolchain --system=linux-x86_64 --ndk-dir=${NDK_ROOT}
ENV PATH ${NDK_ROOT}:$PATH
ENV ANDROID_NDK_HOME ${NDK_ROOT}



RUN cd /installs && git clone https://github.com/jedisct1/libsodium.git
RUN cd /installs/libsodium && git checkout && ./autogen.sh
RUN cd /installs/libsodium && ./configure && make && make check && make install

RUN cd /installs/libsodium/dist-build && /bin/sed -i '/#!\/bin\/sh/c\#!\/bin\/bash' android-arm.sh
RUN cd /installs/libsodium/dist-build && /bin/sed -i '/#!\/bin\/sh/c\#!\/bin\/bash' android-build.sh
RUN cd /installs/libsodium && ./dist-build/android-arm.sh
RUN cd /installs/libsodium && ./dist-build/android-x86.sh

RUN cd /installs && git clone https://github.com/joshjdevl/kalium-jni && cd /installs/kalium-jni && git pull

RUN cd /installs/kalium-jni/jni && ./installswig.sh
RUN cd /installs/kalium-jni && git pull && git pull
RUN cd /installs/kalium-jni/jni && ./compile.sh
RUN cd /installs/kalium-jni && mvn -q clean install
RUN cd /installs/kalium-jni && ./singleTest.sh
RUN cd /installs/kalium-jni && git pull && ndk-build

