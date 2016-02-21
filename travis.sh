#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    ./build-mac.sh > /dev/null 2>&1
else
    ./dependencies-linux.sh > /dev/null 2>&1
    ./build.sh > /dev/null 2>&1
fi
