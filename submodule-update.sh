#!/bin/bash -ev

set -ev

. ./setenv.sh

( cd libsodium && git reset --hard )

git submodule init
git submodule sync
#git submodule update --remote --merge
git submodule update
