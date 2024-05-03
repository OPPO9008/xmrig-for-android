#!/bin/bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT/hwloc


if [ ! -f "configure" ]; then
  ./autogen.sh
fi


archs=(arm arm64 x86 x86_64)
for arch in ${archs[@]}; do
    case ${arch} in
        "arm")
            target_host=arm-linux-androideabi
            ANDROID_ABI="armeabi-v7a"
            ach=arm
            gccname=arm-linux-androideabi-4.9
            git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git  --depth 1 $ANDROID_NDK_ROOT/toolchains/$gccname
            ;;
        "arm64")
            target_host=aarch64-linux-android
            ANDROID_ABI="arm64-v8a"
            ach=aarch64
            gccname=aarch64-linux-android-4.9
            git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git --depth 1 $ANDROID_NDK_ROOT/toolchains/$gccname
            ;;
        "x86")
            target_host=i686-linux-android
            ANDROID_ABI="x86"
            ach=x86
            gccname=i686-linux-android-4.7
            git clone https://github.com/pstglia/i686-linux-android-4.7 --depth 1 $ANDROID_NDK_ROOT/toolchains/$gccname
            ;;
        "x86_64")
            target_host=x86_64-linux-android
            ANDROID_ABI="x86_64"
            ach="x86"
            gccname=x86_64-linux-android-4.9
            git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9 -b android10-dev --depth 1 $ANDROID_NDK_ROOT/toolchains/$gccname
            ;;
        *)
            exit 16
            ;;
    esac

    TARGET_DIR=$EXTERNAL_LIBS_ROOT/hwloc/$ANDROID_ABI
    PATH=$ANDROID_NDK_ROOT/toolchains/$gccname/bin:$PATH
    

    if [ -f "$TARGET_DIR/lib/hwloc.la" ]; then
      continue
    fi

    mkdir -p $TARGET_DIR
    echo "building for ${arch}"

mkdir -p $TARGET_DIR/include
cp include/hwloc.h $TARGET_DIR/include
        ./configure  \
        --prefix=${TARGET_DIR} \
        --host=${target_host} \
        --target=${target_host} \
        --disable-shared \
        --enable-static \
        --disable-io \
        --disable-libudev \
        --disable-libxml2 \
        && make -j 4 CFLAGS+="-O3"\
        && make install \
        && make clean
cat config.log

done

exit 0
