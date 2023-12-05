#!/bin/bash

VERSION=6.0.1

pushd .
cd ffmpeg-$VERSION
if [ ! -d "mybuild" ]; then
    mkdir mybuild
fi

cd mybuild
echo "Configure FFmpeg source $VERSION..."
PATH=/usr/local/cuda-10.2/bin:$PATH ../configure --prefix=/usr/local/ffmpeg-6.0 --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda-10.2/include --extra-ldflags="-L/usr/local/cuda-10.2/lib64 -L/usr/local/lib" --disable-static --enable-shared --enable-gpl --enable-gnutls --enable-libass --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libmp3lame --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librubberband --enable-librsvg --enable-libshine --enable-libsnappy  --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm  --enable-libx264 --nvccflags='-gencode arch=compute_35,code=sm_35 -gencode arch=compute_75,code=compute_75 -O2' --enable-cuvid --nvcc=/usr/local/cuda-10.2/bin/nvcc
popd
