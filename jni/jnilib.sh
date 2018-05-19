#!/bin/bash -ev

gcc -I../libsodium/src/libsodium/include -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux -I${JAVA_HOME}/include/darwin sodium_wrap.c -shared -fPIC -L ../libsodium/libsodium-host/lib -L/usr/local/lib -L/usr/lib -lsodium -o $jnilib

