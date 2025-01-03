#!/bin/bash
set -e

ROOT=/
LO=/core
DP=/deps
LO_3RD=$LO/workdir/UnpackedTarball
pwd

ls -alh $ROOT

# build dependencies
cd $LO
pwd
/opt/lo/bin/make fetch
/opt/lo/bin/make PARALLELISM=1 xmlsec.allbuild
/opt/lo/bin/make UnpackedTarball

/opt/lo/bin/make argon2
/opt/lo/bin/make boost
/opt/lo/bin/make box2d
/opt/lo/bin/make curl
/opt/lo/bin/make dtoa
/opt/lo/bin/make epoxy
/opt/lo/bin/make expat
/opt/lo/bin/make graphite
/opt/lo/bin/make harfbuzz
/opt/lo/bin/make icu
/opt/lo/bin/make lcms2
/opt/lo/bin/make libexttextcat
/opt/lo/bin/make libjpeg-turbo
/opt/lo/bin/make liblangtag
/opt/lo/bin/make libpng
/opt/lo/bin/make libtiff
/opt/lo/bin/make libwebp
/opt/lo/bin/make libxml2
/opt/lo/bin/make nss

/opt/lo/bin/make cppunit
/opt/lo/bin/make sal
/opt/lo/bin/make skia
/opt/lo/bin/make pdfium

# debug
ls -alhd $LO/workdir/UnpackedTarball/*/
ls -alh $LO/instdir/program/
du -ah $LO/instdir/
du -ah $LO/workdir/

# # copy libraries
# cd $ROOT
# mkdir -p $DP/libs

# cp -a $LO_3RD/curl/lib/.libs/lib*.so* $DP/libs/
# cp -a $LO_3RD/harfbuzz/src/.libs/libharfbuzz.a $DP/libs/
# cp -a $LO_3RD/icu/source/lib/lib*.so* $DP/libs/
# cp -a $LO_3RD/lcms2/src/.libs/lib*.so* $DP/libs/
# cp -a $LO_3RD/libexttextcat/src/.libs/libexttextcat-2.0.a $DP/libs/
# cp -a $LO_3RD/liblangtag/liblangtag/.libs/liblangtag*.so* $DP/libs/
# cp -a $LO_3RD/libtiff/libtiff/.libs/libtiff.a $DP/libs/
# cp -a $LO_3RD/libwebp/sharpyuv/.libs/libsharpyuv.a $DP/libs/
# cp -a $LO_3RD/libwebp/src/.libs/libwebp.a $DP/libs/

# cp $LO/instdir/program/*.dll $DP/libs/
# cp $LO/workdir/LinkTarget/StaticLibrary/lib*.a $DP/libs/

# # copy headers
# mkdir -p $DP/inc
# mkdir -p $DP/inc/liblangtag

# cp -r $LO_3RD/argon2/include/*.h $DP/inc/
# cp -r $LO_3RD/boost/boost $DP/inc/
# cp -r $LO_3RD/box2d/include/box2d $DP/inc/
# cp -r $LO_3RD/curl/include/curl $DP/inc/
# cp -r $LO_3RD/dragonbox/include/dragonbox $DP/inc/
# cp -r $LO_3RD/dtoa/include/*.h $DP/inc/
# cp -r $LO_3RD/frozen/include/frozen $DP/inc/
# cp -r $LO_3RD/harfbuzz/src/*.h $DP/inc/
# cp -r $LO_3RD/icu/source/common/unicode $DP/inc/
# cp -r $LO_3RD/icu/source/i18n/unicode $DP/inc/
# cp -r $LO_3RD/icu/source/io/unicode $DP/inc/
# cp -r $LO_3RD/lcms2/include/*.h $DP/inc/
# cp -r $LO_3RD/libexttextcat/src/*.h $DP/inc/
# cp -r $LO_3RD/liblangtag/liblangtag/*.h $DP/inc/liblangtag/
# cp -r $LO_3RD/libtiff/libtiff/*.h $DP/inc/
# cp -r $LO_3RD/libwebp/src/webp $DP/inc/
# cp -r $LO_3RD/mdds/include/mdds $DP/inc/
# cp -r $LO_3RD/zxcvbn-c/zxcvbn.h $DP/inc/
