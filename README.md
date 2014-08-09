# kalium-jni - Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html). All the hard work of making a portable NaCl API version was done by [Frank Denis](https://github.com/jedisct1) on [libsodium](https://github.com/jedisct1/libsodium) and kalium was totally inspired by [Tony Arcieri's](https://github.com/tarcieri) work with [RbNaCl](https://github.com/cryptosphere/rbnacl) and [kalium](https://github.com/abstractj/kalium).   


## Requirements

* JDK 6 or [higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Apache Maven](http://maven.apache.org/guides/getting-started/)

## Installation 

###Shared Library and Jar File

Please install docker and then run the [copy script](https://github.com/joshjdevl/docker-libsodium/blob/master/copy-files-to-host.sh)

This will then pull the docker container from [docker-libsodium](https://registry.hub.docker.com/u/joshjdevl/docker-libsodium/) which is a Trusted Build.

### Manual compilation and installation

Please refer to the [installation instructions](INSTALL.md) for more details or the (docker build)[https://github.com/joshjdevl/docker-libsodium/blob/master/Dockerfile]
   
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
 
### Notes

kalium-jni is a work in progress, feedback, bug reports and patches are always welcome.

[Docker build](https://github.com/joshjdevl/docker-libsodium)

[Docker container](https://index.docker.io/u/joshjdevl/docker-libsodium/)


### Issues / Improvements / Help Seeked

if anyone understands travis-ci and how to configure maven tests to find jni libraries, please submit a patch or email me
[travis-ci build](https://travis-ci.org/joshjdevl/kalium-jni/)

the blake tests have been commented out, there were some strange jni errors

Everything has been tested and working on ubuntu 12.04 32bit and 64 bit, macos, and Android

