# kalium-jni - Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html).

Credits to:
* [**Libsodium**](https://github.com/jedisct1/libsodium): author [Frank Denis](https://github.com/jedisct1) and [Contributors](https://github.com/jedisct1/libsodium/graphs/contributors)
* [**Kalium**](https://github.com/abstractj/kalium): author [abstractj](https://github.com/abstractj) and [Contributors](https://github.com/abstractj/kalium/graphs/contributors)
* [**Robosodium**](https://github.com/GerardSoleCa/Robosodium): author [GerardSoleCa](https://github.com/GerardSoleCa)
* [**libstodium**](https://github.com/ArteMisc/libstodium): author [ArteMisc](https://github.com/ArteMisc)


## Requirements

* JDK 6 or [higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Apache Maven](http://maven.apache.org/guides/getting-started/)

## Installation 

###Shared Library and Jar File

Please install docker and then run the [copy script](https://github.com/joshjdevl/docker-libsodium/blob/master/copy-files-to-host.sh)

This will then pull the docker container from [docker-libsodium](https://registry.hub.docker.com/u/joshjdevl/docker-libsodium/) which is a Trusted Build.

### Manual compilation and installation

Please refer to the [installation instructions](INSTALL.md) for more details or the [docker build](https://github.com/joshjdevl/docker-libsodium/blob/master/Dockerfile)
   
#### Add kalium-jni to your Android project

Add the generated .jar file (~/.m2/repository/org/abstractj/kalium/kalium-jni/x.x.x-SNAPSHOT.jar) in your android project or add as a maven dependency:

Add as a Maven dependency at your project:

    <dependency>
        <groupId>org.abstractj.kalium</groupId>
        <artifactId>kalium-jni</artifactId>
        <version>1.0.0-SNAPSHOT</version>
        <scope>compile</scope>
    </dependency>

Add libkaliumjni.so that you'll find inside libs folder(kalium-jni/libs) in jniLibs (src/main/jniLibs) folder of your project.
 
### Notes

kalium-jni is a work in progress, feedback, bug reports and patches are always welcome.

[Docker container](https://hub.docker.com/r/joshjdevl/kalium-jni/)


### Issues / Improvements / Help Seeked

the blake tests have been commented out, there were some strange jni errors

Everything has been tested and working on ubuntu 12.04 32bit and 64 bit, macos, and Android

