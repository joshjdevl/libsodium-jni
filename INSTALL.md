# kalium-jni - Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html). All the hard work of making a portable NaCl API version was done by [Frank Denis](https://github.com/jedisct1) on [libsodium](https://github.com/jedisct1/libsodium) and kalium was totally inspired by [Tony Arcieri's](https://github.com/tarcieri) work with [RbNaCl](https://github.com/cryptosphere/rbnacl) and [kalium](https://github.com/abstractj/kalium).   


## Requirements

* JDK 6 or [higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Apache Maven](http://maven.apache.org/guides/getting-started/)

## Installation

### libsodium

kalium-jni is implemented using [jni](http://docs.oracle.com/javase/6/docs/technotes/guides/jni/) and [swig](http://www.swig.org/) to bind the shared libraries from [libsodium](https://github.com/jedisct1/libsodium). For a more detailed explanation, please refer to [RbNaCl's documentation](https://github.com/cryptosphere/rbnacl/blob/master/README.md).

#### OS X users can get libsodium via [homebrew](http://mxcl.github.com/homebrew/) with: 

    brew install libsodium 

#### Ubuntu 14.04 LTS users need to do:

Install dependencies:

    sudo apt-get install git build-essential libtool automake openjdk-7-jdk maven ruby libpcre3-dev

Android NDK installation (Only if you don't have NDK installed)

    wget http://dl.google.com/android/ndk/android-ndk-r9d-linux-x86_64.tar.bz2
    tar -xjvf android-ndk-r9d-linux-x86_64.tar.bz2
    cd android-ndk-r9d
    export ANDROID_NDK_HOME=`pwd`  ##If you have the Android NDK already installed, change 'pwd' for your NDK path.

### Download Libsodium

    git clone https://github.com/jedisct1/libsodium.git
    cd libsodium
    ./autogen.sh

## Generate Android libs for all architectures.

    ./dist-build/android-arm.sh
    ./dist-build/android-armv7.sh
    ./dist-build/android-mips.sh
    ./dist-build/android-x86.sh
    cd ..

### kalium-jni installation

    git clone https://github.com/joshjdevl/kalium-jni && cd kalium-jni
    cd jni
    ./installswig.sh

All methods that you want to call from java code we have to be declared in sodium.i. Sodium.i has to be update, currently you can't call all functions of Libsodium.

    ./compile.sh
    

Declare Java location if you don't declared yet and add Android NDK to the path.
If libsodium path installation isn't /installs/libsodium you must change the libsodium reference that you'll find inside kalium-jni/jni/Android.mk for your custom location.

    export JAVA_HOME=/usr/bin/
    export PATH=$PATH:$ANDROID_NDK_HOME
    cd ..
    ndk-build

Now we generate the .jar file

    mvn clean install

#### Add kalium-jni to your Android project

Add the generated .jar file (~/.m2/repository/org/abstractj/kalium/kalium-jni/x.x.x-SNAPSHOT.jar) in your android project or add as a maven dependency:

Add as a Maven dependency at your project:

    <dependency>
        <groupId>org.abstractj.kalium</groupId>
        <artifactId>kalium-jni</artifactId>
        <version>1.0.0-SNAPSHOT</version>
        <scope>compile</scope>
    </dependency>

Add libtest.so that you'll find inside libs folder(kalium-jni/libs) in jniLibs (src/main/jniLibs) folder of your project.

