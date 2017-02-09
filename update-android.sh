#!/bin/bash -ev

echo y | android update sdk --all --filter extra-android-m2repository --no-ui
echo y | android update sdk --all --filter build-tools-23.0.2 --no-ui
echo y | android update sdk --all --filter build-tools-23.0.3 --no-ui
echo y | android update sdk --all --filter build-tools-25.0.2 --no-ui
echo y | android update sdk --all --filter android-16 --no-ui
echo y | android update sdk --all --filter android-21 --no-ui
echo y | android update sdk --all --filter android-23 --no-ui
echo y | android update sdk --all --filter android-24 --no-ui
echo y | android update sdk --all --filter android-25 --no-ui
