> **This project is entirely maintained in my spare time. Donations are appreciated:** :clap:<br/><br/>
> **Bitcoin address:** 1EC6j1f2sDGy9L8ma8FFfQyxt9mb9a6Xxy <br/>
> **Bitcoin Cash address:** 1PSxB3DRCkeaZK7nSbJ1hoxbsWAXwM8Hyx <br/>
> **Ethereum address:** 2f30c73e8d643356ebbcfee7013ccd03c05097fb <br/>
> **Peercoin address:** PQUavHtRCLtevq75GhLCec41nvDtmM4wvf <br/>
> **Raiblocks address:** xrb_1dxetbqeo38gcxejt8n6utajorrntbfrr1qftpw7qwarw6d8kp74fwmcuqi9  <br/>
> **Monero address:** 48btz6nV4SjWyhDpkXrVVXAtgN6aStdnz8weMyB6qAMhhBVqiy1v3HC6XL1j7K27ZfFRhpw3Y4A4uE8o2PXMxFxY1Q5gGvW


[![Build Status](https://travis-ci.org/joshjdevl/libsodium-jni.svg)](https://travis-ci.org/joshjdevl/libsodium-jni)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/com.github.joshjdevl.libsodiumjni/libsodium-jni/badge.svg)](https://oss.sonatype.org/#nexus-search;quick~libsodium)

# libsodium-jni - (Android) Java JNI binding to the Networking and Cryptography (NaCl) library 

A Java JNI binding (to allow for Java and Android integration) to [Networking and Cryptography](http://nacl.cr.yp.to/) library by [Daniel J. Bernstein](http://cr.yp.to/djb.html).

**Why JNI and not JNA? JNI is much faster than JNA and JNI is faster than JNR.**

If you do use this project in your research project, please do cite this repo. Thanks!

> Credits to: <br/>
> * [**Libsodium**](https://github.com/jedisct1/libsodium): author [Frank Denis](https://github.com/jedisct1) and [Contributors](https://github.com/jedisct1/libsodium/graphs/contributors)
> * [**Kalium**](https://github.com/abstractj/kalium): author [abstractj](https://github.com/abstractj) and [Contributors](https://github.com/abstractj/kalium/graphs/contributors)
> * [**Robosodium**](https://github.com/GerardSoleCa/Robosodium): author [GerardSoleCa](https://github.com/GerardSoleCa)
> * [**libstodium**](https://github.com/ArteMisc/libstodium): author [ArteMisc](https://github.com/ArteMisc)


## Installation

* Java package is under `org.libsodium.jni` 
* Maven coordinates are in the Sonatype OSS [repository](https://oss.sonatype.org/#nexus-search;quick~libsodium)

### Android Archive (AAR)
    <dependency>
        <groupId>com.github.joshjdevl.libsodiumjni</groupId>
        <artifactId>libsodium-jni-aar</artifactId>
        <version>2.0.1</version>
        <type>aar</type>
    </dependency>

### Android Gradle (AAR)
1. Add library to dependencies:
```gradle
// build.gradle
dependencies {
    ...
    compile 'com.github.joshjdevl.libsodiumjni:libsodium-jni-aar:2.0.1'
}
```
2. To fix the warning [allowBackup](src/main/AndroidManifest.xml), add `xmlns:tools="http://schemas.android.com/tools"` and `tools:replace="android:allowBackup"` to your Manifest:
```xml
<!-- AndroidManifest.xml -->
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="com.name.myapp">
    <application
            ...
            tools:replace="android:allowBackup">
        <activity android:name=".MainActivity">
            ...
        </activity>
    </application>
</manifest>
```

### Java Archive (JAR)

    <dependency>
        <groupId>com.github.joshjdevl.libsodiumjni</groupId>
        <artifactId>libsodium-jni</artifactId>
        <version>2.0.1</version>
        <type>jar</type>
    </dependency>



### Usage
#### Java
Example [invocations](src/test/java/org/libsodium/jni/publickey/AuthenticatedEncryptionTest.java)

* import org.libsodium.jni.NaCl; (this calls System.loadLibrary("sodiumjni");)
* call NaCl.sodium(). {whatever_method_you_want}
* Note that Android [allowBackup is set to false](src/main/AndroidManifest.xml). WARNING Your application can override the allow backup, just be sure that there is no sensitive data or secrets that might be backed up. Option can be used with  `tools:replace="android:allowBackup"`

#### Kotlin
```kotlin
// MainActivity.kt

import org.libsodium.jni.SodiumConstants
import org.libsodium.jni.crypto.Random
import org.libsodium.jni.keys.KeyPair

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Test Libsodium
        val seed = Random().randomBytes(SodiumConstants.SECRETKEY_BYTES)
        val encryptionKeyPair = KeyPair(seed)
        Log.i("PUBLIC KEY:", encryptionKeyPair.publicKey.toString())
    }
}

```

## Manual Compilation and Installation

### MacOS Manual Compilation and Installation

Install brew

Run [./dependencies-mac.sh](dependencies-mac.sh)

Run [./build-mac.sh](build-mac.sh)

### Linux Manual Compilation and Installation

Run [./dependencies-linux.sh](dependencies-linux.sh)

Run [./build-linux.sh](build-linux.sh)

## Docker Container

The docker container is available from [libsodium-jni](https://hub.docker.com/r/joshjdevl/libsodium-jni/) which is a Automated Build.

### Manual compilation and installation

Please refer to the [docker build](https://github.com/joshjdevl/libsodium-jni/blob/master/Dockerfile) for the commands used to build.

### Notes

[Docker container](https://hub.docker.com/r/joshjdevl/libsodium-jni/)

## Vagrant

A [Vagrantfile](Vagrantfile) is available for those that would like to set up a virtual machine.


## Example application
Clone the repo and import project from folder example/Sodium in Android studio (Android studio 2.1). Android studio will handle the rest.
Compile and run. Tested to emulators down to Android Version 16.

## Manual AAR usage
To use the AAR project as is (No .SO file imports needed).

It is also possible to build the AAR library yourself using the provided scripts [linux](build-linux.sh) or [mac](build-mac.sh). After building the library open module settings and add the libsodium-jni-release.aar and/or libsodium-jni-debug.aar as a dependency.

### Custom code usage
To use the library with your own custom code, skip the aar file and add

1. The native .SO libraries in your project (Create jnilibs folder and make the required changes to the gradle file)
2. Add the source code from the src folder and add your own additional code.


### Issues / Improvements / Help Seeked :v:

*libsodium-jni* is currently being used in production. Feedback, bug reports and patches are always welcome. Everything has been tested and working on ubuntu 12.04 32bit and 64 bit, macos, and Android.

`gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 4524D716`

### SWIG Extensions

SWIG is used to generate the Java JNI bindings. This means that the same interface definition can be used to generate bindings for all languages supported by SWIG. The interface can be found [here](jni/sodium.i)
