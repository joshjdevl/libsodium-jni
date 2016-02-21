#!/bin/bash -ev

set -e


if [ -z "$JAVA_HOME" ]; then
    if uname -a | grep -q -i darwin; then
        export JAVA_HOME=$(/usr/libexec/java_home)
    else
        echo "ERROR You should set JAVA_HOME"
        echo "Exiting!"
        exit 1
    fi
fi


C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"
export C_INCLUDE_PATH

rm -f *.java
rm -f *.c
rm -f *.so

export PATH=/usr/local/bin:$PATH

swig -java -package org.libsodium.jni -outdir ../src/main/java/org/libsodium/jni sodium.i


jnilib=libsodiumjni.so
destlib=/usr/lib
if uname -a | grep -q -i darwin; then
  jnilib=libsodiumjni.jnilib
  destlib=~/Library/Java/Extensions
  if [ ! -d $destlib ]; then
      sudo mkdir $destlib
  fi
else
  ldconfig
fi
echo $jnilib
echo $destlib
echo $destlib/$jnilib 

#sudo cp /usr/local/lib/libsodium.* /usr/lib

gcc -I../libsodium/src/libsodium/include -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I${JAVA_HOME}/include/darwin sodium_wrap.c -shared -fPIC -L/usr/local/lib -L/usr/lib -lsodium -o $jnilib
sudo rm -f $destlib/$jnilib  
sudo cp $jnilib $destlib

