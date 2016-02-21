#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    ./build-mac.sh > /dev/null 2>&1
else
    ./build-linux.sh > /dev/null 2>&1
fi
