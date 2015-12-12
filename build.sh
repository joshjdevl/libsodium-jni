#!/usr/bin/bash`

set -ev

pushd /installs

git clone https://github.com/jedisct1/libsodium.git
pushd libsodium && git checkout && ./autogen.sh
./configure && make && make check && make install

pushd dist-build && /bin/sed -i '/#!\/bin\/sh/c\#!\/bin\/bash' android-arm.sh
cd /installs/libsodium/dist-build && /bin/sed -i '/#!\/bin\/sh/c\#!\/bin\/bash' android-build.sh
cd /installs/libsodium && ./dist-build/android-arm.sh
cd /installs/libsodium && ./dist-build/android-x86.sh

cd /installs && git clone https://github.com/joshjdevl/kalium-jni && cd /installs/kalium-jni && git pull

cd /installs/kalium-jni/jni && ./installswig.sh
cd /installs/kalium-jni && git pull && git pull
cd /installs/kalium-jni/jni && ./compile.sh
cd /installs/kalium-jni && mvn -q clean install
cd /installs/kalium-jni && ./singleTest.sh
cd /installs/kalium-jni && git pull && ndk-build

