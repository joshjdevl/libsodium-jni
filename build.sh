#!/usr/bin/bash`

set -ev

pushd /installs

git clone https://github.com/jedisct1/libsodium.git
pushd libsodium 
git checkout && ./autogen.sh
./configure && make && make check && make install

pushd dist-build 
./android-arm.sh
./android-build.sh
./android-arm.sh
./android-x86.sh
popd

popd

rm -rf libsodium
git submodule init
git submodule update

#cd /installs && git clone https://github.com/joshjdevl/kalium-jni && cd /installs/kalium-jni && git pull

pushd jni
./installswig.sh
./compile.sh
mvn -q clean install
./singleTest.sh
ndk-build

