#!/bin/bash -ev

set -ev

. ./setenv.sh

git submodule init
git submodule sync
#git submodule update --remote --merge
git submodule update

pushd libsodium
git reset --hard
#git clean -fdx # Uncomment to force full rebuild

#git fetch && git checkout stable
#git reset --hard origin/stable
#git pull
popd
