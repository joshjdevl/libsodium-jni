This project is entirely maintained in my spare time. Donations are appreciated.

Bitcoin address: 1EC6j1f2sDGy9L8ma8FFfQyxt9mb9a6Xxy

Bitcoin Cash address: 1PSxB3DRCkeaZK7nSbJ1hoxbsWAXwM8Hyx

Ethereum address: 2f30c73e8d643356ebbcfee7013ccd03c05097fb

Peercoin address: PQUavHtRCLtevq75GhLCec41nvDtmM4wvf

[![Build Status](https://travis-ci.org/joshjdevl/libsodium-jni.svg)](https://travis-ci.org/joshjdevl/libsodium-jni)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/com.github.joshjdevl.libsodiumjni/libsodium-jni/badge.svg)](https://oss.sonatype.org/#nexus-search;quick~libsodium)

# libsodium-jni - (Android) Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html).

If you do use this project in your research project, please do cite this repo. Thanks!

Credits to:
* [**Libsodium**](https://github.com/jedisct1/libsodium): author [Frank Denis](https://github.com/jedisct1) and [Contributors](https://github.com/jedisct1/libsodium/graphs/contributors)
* [**Kalium**](https://github.com/abstractj/kalium): author [abstractj](https://github.com/abstractj) and [Contributors](https://github.com/abstractj/kalium/graphs/contributors)
* [**Robosodium**](https://github.com/GerardSoleCa/Robosodium): author [GerardSoleCa](https://github.com/GerardSoleCa)
* [**libstodium**](https://github.com/ArteMisc/libstodium): author [ArteMisc](https://github.com/ArteMisc)


## Installation 

* Java package is under org.libsodium.jni
* Maven coordinates are in the Sonatype OSS [repository](https://oss.sonatype.org/#nexus-search;quick~libsodium)

### Android Archive (AAR)
    <dependency>
        <groupId>com.github.joshjdevl.libsodiumjni</groupId>
        <artifactId>libsodium-jni-aar</artifactId>
        <version>1.0.7</version>
        <type>aar</type>
    </dependency>

### Java Archive (JAR)

    <dependency>
        <groupId>com.github.joshjdevl.libsodiumjni</groupId>
        <artifactId>libsodium-jni</artifactId>
        <version>1.0.7</version>
        <type>jar</type>
    </dependency>

### MacOS Manual Compilation and Installation

Install brew

Run [./build-mac.sh](build-mac.sh)

### Linux Manual Compilation and Installation

Run [./build-linux.sh](build-linux.sh)

### To use the example app
Clone the repo and import project from folder example/Sodium in Android studio (Android studio 2.1). Android studio will handle the rest.
Compile and run. Tested to emulators down to Android Version 16.

### AAR usage
To use the AAR project as is (No .SO file imports needed).


It is also possible to build the AAR library yourself using the provided scripts [linux](build-linux.sh) or [mac](build-mac.sh). After building the library open module settings and add the libsodium-jni-release.aar and/or libsodium-jni-debug.aar as a dependency.

### Custom code usage
To use the library with your own custom code, skip the aar file and add

1. The native .SO libraries in your project (Create jnilibs folder and make the required changes to the gradle file)
2. Add the source code from the src folder and add your own additional code.

### Docker Container

The docker container is available from [libsodium-jni](https://hub.docker.com/r/joshjdevl/libsodium-jni/) which is a Automated Build.

### Manual compilation and installation

Please refer to the [docker build](https://github.com/joshjdevl/libsodium-jni/blob/master/Dockerfile) for the commands used to build.
   
### Notes

[Docker container](https://hub.docker.com/r/joshjdevl/libsodium-jni/)


### Issues / Improvements / Help Seeked

libsodium-jni is currently being used in production. Feedback, bug reports and patches are always welcome.

Everything has been tested and working on ubuntu 12.04 32bit and 64 bit, macos, and Android

gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 4524D716

### SWIG Extensions

SWIG is used to generate the Java JNI bindings. This means that the same interface definition can be used to generate bindings for all languages supported by SWIG. The interface can be found [here](jni/sodium.i)
