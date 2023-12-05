#!/bin/bash

VERSION=6.0.1

pushd .
cd ffmpeg-$VERSION
if [ ! -d "mybuild" ]; then
  echo "NO mybuild directory found!"
  exit 1
fi

cd mybuild
echo "Building with $((`nproc`-2)) threads"
make -j$((`nproc`-2)) V=1 2>&1 | tee build.log

echo "Generate .deb package"
echo "ffmpeg 6.0" > description-pak && \
sudo checkinstall -Dy --install=no --nodoc --pkgname="ffmpeg-6.0" --pkgversion="6.0" --pakdir="../packages"
