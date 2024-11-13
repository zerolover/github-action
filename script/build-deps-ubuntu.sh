#!/bin/bash
set -e

ROOT=/workspace
LO=$ROOT/core
DP=$ROOT/dolphin

cd $LO
./autogen.sh --without-java --without-doxygen --without-help --disable-online-update
make fetch
make UnpackedTarball
make boost
make box2d
make curl
make dtoa
make expat
make harfbuzz
make libtiff
make zxing
make zxcvbn-c

cd $ROOT
mkdir -p $DP/libs
cp $LO/workdir/LinkTarget/StaticLibrary/lib*.a $DP/libs/
cp -a $LO/workdir/UnpackedTarball/liblangtag/liblangtag/.libs/liblangtag*.so* $DP/libs/
cp -a $LO/workdir/UnpackedTarball/icu/source/lib/lib*.so* $DP/libs/
cp $LO/workdir/UnpackedTarball/curl/lib/.libs/libcurl.so $DP/libs/
cp $LO/workdir/UnpackedTarball/lcms2/src/.libs/liblcms2.so $DP/libs/
cp $LO/workdir/UnpackedTarball/libwebp/src/.libs/libwebp.a $DP/libs/
cp $LO/workdir/UnpackedTarball/libwebp/sharpyuv/.libs/libsharpyuv.a $DP/libs/
cp $LO/workdir/UnpackedTarball/harfbuzz/src/.libs/libharfbuzz.a $DP/libs/
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.32 $DP/libs/libstdc++.so.6

mkdir -p $DP/inc
cp $LO/workdir/UnpackedTarball/libtiff/libtiff/*.h $DP/inc/
cp -r $LO/workdir/UnpackedTarball/boost/boost $DP/inc/
cp -r $LO/workdir/UnpackedTarball/curl/include/curl $DP/inc/
