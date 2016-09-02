#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    #./build-mac.sh > /dev/null
    ./dependencies-mac.sh
    travis_wait ./build.sh
    ./build-kaliumjni.sh
else
    ./build-linux.sh
fi
