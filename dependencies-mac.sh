#!/bin/bash -ev

#brew upgrade libtool autoconf automake swig android-sdk android-ndk gradle libsodium maven
#https://stackoverflow.com/questions/20802320/detect-if-homebrew-package-is-installed/20802381#20802381
for pkg in libtool autoconf automake swig android-sdk android-ndk gradle libsodium maven; do
    if brew list -1 | grep -q "^${pkg}\$"; then
        echo "Package '$pkg' is installed"            
        #brew upgrade $pkg
    else
        echo "Package '$pkg' is not installed"            
        brew install $pkg
    fi
done

brew upgrade libtool autoconf automake swig android-sdk android-ndk gradle libsodium maven

./update-android.sh
