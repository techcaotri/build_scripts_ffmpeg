#!/bin/bash

VERSION=6.0.1

ANDROID_ABI=arm64-v8a
INSTALL_DIR=$(pwd)/android_install
PREFIX=$INSTALL_DIR/$ANDROID_ABI

pushd .
cd ffmpeg-$VERSION
if [ ! -d "mybuild_android" ]; then
    mkdir mybuild_android
fi

# cd mybuild_android
# echo "Configure FFmpeg source $VERSION..."
# ../configure --prefix=$pwd/android_install --enable-nonfree --enable-libnpp --disable-static --enable-shared --enable-gpl --enable-gnutls \
#   --enable-libass --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libmp3lame --enable-libopenjpeg --enable-libopenmpt \
#   --enable-libopus --enable-libpulse --enable-librubberband --enable-librsvg --enable-libshine --enable-libsnappy  --enable-libssh --enable-libtheora --enable-libtwolame \
#   --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-openal --enable-opengl \
#   --enable-sdl2 --enable-libdc1394 --enable-libdrm  --enable-libx264 \
#   --enable-cross-compile \
#   --target-os=android \
#   --extra-cflags="-O3 -fPIC $DEP_CFLAGS" \
#   --extra-ldflags="$DEP_LD_FLAGS" \
#   --enable-jni --enable-mediacodec 
# popd

cd mybuild_android
echo "Configure FFmpeg source $VERSION..."

export NDK="/home/tripham/Android/Sdk/ndk/23.1.7779620"
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
AR=$TOOLCHAIN/bin/llvm-ar
NM=$TOOLCHAIN/bin/llvm-nm
RANLIB=$TOOLCHAIN/bin/llvm-ranlib
STRIP=$TOOLCHAIN/bin/llvm-strip
#architecture arm64-v8a
ARCH=arm64
CPU=armv8-a
API=28
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
OPTIMIZE_CFLAGS="-march=$CPU"

function configure_android
{
  ../configure \
    --prefix=$PREFIX \
    --disable-debug \
    --enable-postproc \
    --disable-asm \
    --enable-doc \
    --enable-ffmpeg \
    --enable-ffplay \
    --enable-ffprobe \
    --enable-symver \
    --enable-static \
    --enable-shared \
    --enable-neon \
    --enable-hwaccels \
    --enable-jni \
    --enable-mediacodec \
    --enable-decoder=h264_mediacodec \
    --enable-decoder=hevc_mediacodec \
    --enable-decoder=mpeg4_mediacodec \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --ar=$TOOLCHAIN/bin/llvm-ar \
    --nm=$TOOLCHAIN/bin/llvm-nm \
    --ranlib=$RANLIB \
    --strip=$STRIP \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS"
  echo "configure complete"
}

configure_android 2>&1 | tee configure.log
popd
