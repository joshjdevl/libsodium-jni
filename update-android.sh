#!/bin/bash -ev

. ./setenv.sh

echo y | sdkmanager "platform-tools" &> sdkmanager.log
echo y | sdkmanager "tools"  >> sdkmanager.log 2>&1


echo y | sdkmanager "extras;android;m2repository"  >> sdkmanager.log 2>&1
echo y | sdkmanager "extras;google;m2repository"  >> sdkmanager.log 2>&1

echo y | sdkmanager "build-tools;23.0.2"  >> sdkmanager.log 2>&1
echo y | sdkmanager "build-tools;23.0.3"  >> sdkmanager.log 2>&1
echo y | sdkmanager "build-tools;25.0.2"   >> sdkmanager.log 2>&1

echo y | sdkmanager "platforms;android-16"  >> sdkmanager.log 2>&1
echo y | sdkmanager "platforms;android-21"  >> sdkmanager.log 2>&1
echo y | sdkmanager "platforms;android-23"  >> sdkmanager.log 2>&1
echo y | sdkmanager "platforms;android-24"  >> sdkmanager.log 2>&1
echo y | sdkmanager "platforms;android-25"  >> sdkmanager.log 2>&1

sdkmanager --update
