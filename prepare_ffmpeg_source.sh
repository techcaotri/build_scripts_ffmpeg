#!/bin/bash

VERSION=6.0.1

echo "Clone FFmpeg source $VERSION..."
git clone -b n$VERSION --depth 1 https://git.ffmpeg.org/ffmpeg.git ffmpeg-$VERSION

pushd .
cd ffmpeg-$VERSION
git checkout -b ffmpeg-n$VERSION
popd
