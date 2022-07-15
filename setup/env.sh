#!/bin/bash
# https://developer.android.com/studio/command-line/variables

export ANDROID_DISABLE_ENV=yes

export ANDROID_HOME=/opt/android/sdk
#export ANDROID_USER_HOME=/opt/android/.android

export ANDROID_NDK=$ANDROID_HOME/ndk/25.0.8775105
export ANDROID_EMULATOR_HOME=$ANDROID_HOME/emulator/user
export ANDROID_AVD_HOME=$ANDROID_EMULATOR_HOME/avd

export STUDIO_JDK=/opt/android/studio/jre
#export STUDIO_PROPERTIES=
#export STUDIO_VM_OPTIONS=
#export STUDIO_GRADLE_JDK=

eval "optbin -s /opt/android/bin"

