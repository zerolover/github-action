#!/bin/bash
set -e

ROOT=/workspace
LO=$ROOT/core
DP=$ROOT/deps
LO_3RD=$LO/workdir/UnpackedTarball

# build dependencies
cd $LO
./autogen.sh --without-java --without-doxygen --without-help --disable-online-update --disable-ccache
make fetch
make UnpackedTarball

make argon2
make boost
make box2d
make curl
make dtoa
make epoxy
make expat
make harfbuzz
make icu
make lcms2
make libexttextcat
make liblangtag
make libpng
make libtiff
make libwebp
make zxcvbn-c
make zxing

# debug
ls -alhd $LO/workdir/UnpackedTarball/*/
ls -alh $LO/instdir/program/

# copy libraries
cd $ROOT
mkdir -p $DP/libs

cp -a $LO_3RD/argon2/libargon2.a $DP/libs/
cp -a $LO_3RD/curl/lib/.libs/lib*.so* $DP/libs/
cp -a $LO_3RD/harfbuzz/src/.libs/libharfbuzz.a $DP/libs/
cp -a $LO_3RD/icu/source/lib/lib*.so* $DP/libs/
cp -a $LO_3RD/lcms2/src/.libs/lib*.so* $DP/libs/
cp -a $LO_3RD/libexttextcat/src/.libs/libexttextcat-2.0.a $DP/libs/
cp -a $LO_3RD/liblangtag/liblangtag/.libs/liblangtag*.so* $DP/libs/
cp -a $LO_3RD/libtiff/libtiff/.libs/libtiff.a $DP/libs/
cp -a $LO_3RD/libwebp/sharpyuv/.libs/libsharpyuv.a $DP/libs/
cp -a $LO_3RD/libwebp/src/.libs/libwebp.a $DP/libs/

cp $LO/instdir/program/libepoxy.so $DP/libs/
cp $LO/workdir/LinkTarget/StaticLibrary/lib*.a $DP/libs/
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.32 $DP/libs/libstdc++.so.6

# copy headers
mkdir -p $DP/inc
mkdir -p $DP/inc/liblangtag

cp -r $LO_3RD/argon2/include/*.h $DP/inc/
cp -r $LO_3RD/boost/boost $DP/inc/
cp -r $LO_3RD/box2d/include/box2d $DP/inc/
cp -r $LO_3RD/curl/include/curl $DP/inc/
cp -r $LO_3RD/dragonbox/include/dragonbox $DP/inc/
cp -r $LO_3RD/dtoa/include/*.h $DP/inc/
cp -r $LO_3RD/frozen/include/frozen $DP/inc/
cp -r $LO_3RD/harfbuzz/src/*.h $DP/inc/
cp -r $LO_3RD/icu/source/common/unicode $DP/inc/
cp -r $LO_3RD/icu/source/i18n/unicode $DP/inc/
cp -r $LO_3RD/icu/source/io/unicode $DP/inc/
cp -r $LO_3RD/lcms2/include/*.h $DP/inc/
cp -r $LO_3RD/libexttextcat/src/*.h $DP/inc/
cp -r $LO_3RD/liblangtag/liblangtag/*.h $DP/inc/liblangtag/
cp -r $LO_3RD/libtiff/libtiff/*.h $DP/inc/
cp -r $LO_3RD/libwebp/src/webp $DP/inc/
cp -r $LO_3RD/mdds/include/mdds $DP/inc/
cp -r $LO_3RD/zxcvbn-c/zxcvbn.h $DP/inc/
