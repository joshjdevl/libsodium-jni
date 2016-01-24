#!/bin/bash

set -e

if uname -a | grep -q -i darwin; then
  brew install swig
else
    VERSION=3.0.8
    wget http://prdownloads.sourceforge.net/swig/swig-${VERSIN}.tar.gz
    tar -xvf swig-${VERSION}.tar.gz
    cd swig-${VERSION}
    ./configure
    make -j 5
    sudo make install
fi

