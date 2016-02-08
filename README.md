# kalium-jni - Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html).

Credits to:
* [**Libsodium**](https://github.com/jedisct1/libsodium): author [Frank Denis](https://github.com/jedisct1) and [Contributors](https://github.com/jedisct1/libsodium/graphs/contributors)
* [**Kalium**](https://github.com/abstractj/kalium): author [abstractj](https://github.com/abstractj) and [Contributors](https://github.com/abstractj/kalium/graphs/contributors)
* [**Robosodium**](https://github.com/GerardSoleCa/Robosodium): author [GerardSoleCa](https://github.com/GerardSoleCa)
* [**libstodium**](https://github.com/ArteMisc/libstodium): author [ArteMisc](https://github.com/ArteMisc)


## Requirements

* JDK 8 or [higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Apache Maven](http://maven.apache.org/guides/getting-started/)

## Installation 

###Shared Library and Jar File

The docker container is available from [libsodium-jni](https://hub.docker.com/r/joshjdevl/libsodium-jni/) which is a Automated Build.

### Manual compilation and installation

Please refer to the [docker build](https://github.com/joshjdevl/libsodium-jni/blob/master/Dockerfile) for the commands used to build.
   
### Notes

libsodium-jni is a work in progress, feedback, bug reports and patches are always welcome.

[Docker container](https://hub.docker.com/r/joshjdevl/libsodium-jni/)


### Issues / Improvements / Help Seeked

the blake tests have been commented out, there were some strange jni errors

Everything has been tested and working on ubuntu 12.04 32bit and 64 bit, macos, and Android

