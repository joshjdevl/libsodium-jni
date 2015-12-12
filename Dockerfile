FROM ubuntu:precise
MAINTAINER joshjdevl < joshjdevl [at] gmail {dot} com>
ENV DEBIAN_FRONTEND noninteractive

ENV NDK_ROOT /installs/android-ndk-r9d
ENV PATH /installs/android-toolchain/bin:${NDK_ROOT}:$PATH
ENV PATH ${NDK_ROOT}:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV ANDROID_NDK_HOME ${NDK_ROOT}

ADD dependencies-linux.sh /installs/dependencies-linux.sh

WORKDIR /installs
RUN ./dependencies-linux.sh

#RUN cd /installs && tar -xf android-ndk-r9d-linux-x86_64.tar.bz2
#RUN  ${NDK_ROOT}/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=/installs/android-toolchain --system=linux-x86_64 --ndk-dir=${NDK_ROOT}



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

