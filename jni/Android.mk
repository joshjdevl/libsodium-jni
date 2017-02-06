# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,k
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

# Bugfix for arm, which should refer to the armv6 folder
# Bugfix for x86, which should refer to the i686 folder
# Bugfix for mips, which should refer to the mips32 folder
MY_ARCH_FOLDER := $(TARGET_ARCH)
ifeq ($(MY_ARCH_FOLDER),arm)
    MY_ARCH_FOLDER = armv6
endif
ifeq ($(MY_ARCH_FOLDER),arm64)
    MY_ARCH_FOLDER = armv8-a
endif
ifeq ($(MY_ARCH_FOLDER),x86)
    MY_ARCH_FOLDER = i686
endif
ifeq ($(MY_ARCH_FOLDER),x86_64)
    MY_ARCH_FOLDER = x86-64
endif
ifeq ($(MY_ARCH_FOLDER),mips)
    MY_ARCH_FOLDER = mips32
endif
ifeq ($(MY_ARCH_FOLDER),mips64)
    MY_ARCH_FOLDER = mips64r6
endif


include $(CLEAR_VARS)
LOCAL_MODULE := sodium
LOCAL_SRC_FILES := ../libsodium/libsodium-android-$(MY_ARCH_FOLDER)/lib/libsodium.a #/installs/libsodium/libsodium-android-(x86|arm|mips)/lib/libsodium.a
LOCAL_LDFLAGS  += -fPIC
LOCAL_LDLIBS   += -Wl,--no-warn-shared-textrel
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE    := sodiumjni
LOCAL_SRC_FILES :=  \
sodium_wrap.c
LOCAL_LDFLAGS  += -fPIC
LOCAL_LDLIBS   += -Wl,--no-warn-shared-textrel
LOCAL_CFLAGS   += -Wall -g -pedantic -std=c99

LOCAL_C_INCLUDES += ../libsodium/libsodium-android-$(MY_ARCH_FOLDER)/include ../libsodium/libsodium-android-$(MY_ARCH_FOLDER)/include/sodium /usr/local/include
LOCAL_STATIC_LIBRARIES += android_native_app_glue sodium
LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true
#LOCAL_LDLIBS += -Wl,--no-warn-shared-textrel
#LOCAL_LDLIBS += -llog -lsodium


include $(BUILD_SHARED_LIBRARY)
