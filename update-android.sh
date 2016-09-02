#!/bin/bash -ev

echo y | android update sdk --all --filter build-tools-23.0.2 --no-ui
echo y | android update sdk --all --filter build-tools-23.0.3 --no-ui
echo y | android update sdk --all --filter android-16 --no-ui
echo y | android update sdk --all --filter android-21 --no-ui
echo y | android update sdk --all --filter android-23 --no-ui
echo y | android update sdk --all --filter android-24 --no-ui
