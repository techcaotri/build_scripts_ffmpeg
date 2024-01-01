#!/bin/bash

VERSION=6.0.1

ANDROID_ABI=arm64-v8a
INSTALL_DIR=$(pwd)/android_install
PREFIX=$INSTALL_DIR/$ANDROID_ABI
OUTPUT_DIR=$(pwd)/android_output

# Function that copies *.so files and headers of the current ANDROID_ABI
# to the proper place inside OUTPUT_DIR
function prepareOutput() {
  OUTPUT_LIB=${OUTPUT_DIR}/lib/${ANDROID_ABI}
  mkdir -p ${OUTPUT_LIB}
  cp ${INSTALL_DIR}/${ANDROID_ABI}/lib/*.so ${OUTPUT_LIB}

  OUTPUT_HEADERS=${OUTPUT_DIR}/include/
  mkdir -p ${OUTPUT_HEADERS}
  cp -r ${INSTALL_DIR}/${ANDROID_ABI}/include/* ${OUTPUT_HEADERS}
}

pushd .
cd ffmpeg-$VERSION
if [ ! -d "mybuild_android" ]; then
  echo "NO mybuild_android directory found!"
  exit 1
fi

cd mybuild_android
echo "Building with $((`nproc`-2)) threads"
make -j$((`nproc`-2)) V=1 2>&1 | tee build.log

make install
popd

prepareOutput
