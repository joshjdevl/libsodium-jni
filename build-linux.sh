#!/bin/bash -ev

. ./setenv.sh

./submodule-update.sh

#needed for mac osx
C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"
export C_INCLUDE_PATH

gradle generateSWIGsource --full-stacktrace
gradle build --full-stacktrace

pushd jni
./jnilib.sh
popd

if uname -a | grep -q -i darwin; then
  echo "macos"
  #not able to run on travis
  #cp: /usr/lib/libsodium.dylib: Operation not permitted
  #sudo cp ./libsodium/libsodium-host/lib/libsodium.dylib /usr/lib
else
  sudo cp ./libsodium/libsodium-host/lib/libsodium.so /usr/lib
  mvn -q clean install
  ./singleTest.sh
fi

#mvn -q clean install
#./singleTest.sh


#./build-kaliumjni.sh
#./build-libsodiumjni.sh
