#!/bin/bash -ev

. ./setenv.sh

./submodule-update.sh

#needed for mac osx
C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"
export C_INCLUDE_PATH

gradle generateSWIGsource --full-stacktrace
#shorten build time by excluding tasks
gradle build -x compileNative_android-westmere -x compileNative_android-mips64r6 -x compileNative_android-mips32 -x compileNative_android-armv6  --full-stacktrace

pushd jni
./jnilib.sh
popd

#not able to run on travis
#cp: /usr/lib/libsodium.dylib: Operation not permitted
#sudo cp ./libsodium/libsodium-host/lib/libsodium.dylib /usr/lib

#mvn -q clean install
#./singleTest.sh


#./build-kaliumjni.sh
#./build-libsodiumjni.sh
