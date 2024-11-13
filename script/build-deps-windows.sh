#!/bin/bash
set -e

ROOT=/
LO=/core
DP=/deps
LO_3RD=$LO/workdir/UnpackedTarball

# build dependencies
cd $LO
/opt/lo/bin/make fetch
# /opt/lo/bin/make PARALLELISM=1 xmlsec.allbuild
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
/opt/lo/bin/make zxcvbn-c

/opt/lo/bin/make cppunit
/opt/lo/bin/make sal
/opt/lo/bin/make skia
/opt/lo/bin/make pdfium

# debug
ls -alhd $LO/workdir/UnpackedTarball/*/
ls -alh $LO/instdir/program/
# du -ah $LO/instdir/
# du -ah $LO/workdir/

# copy libraries
cd $ROOT
mkdir -p $DP/libs
cp $LO/instdir/program/*.dll $DP/libs/
cp $LO/workdir/LinkTarget/StaticLibrary/*.lib $DP/libs/
cp $LO/workdir/LinkTarget/Library/*.lib $DP/libs/

cp $LO_3RD/argon2/vs2015/build/Argon2OptDll.lib $DP/libs/
cp $LO_3RD/harfbuzz/src/.libs/libharfbuzz.lib $DP/libs/
cp $LO_3RD/icu/source/lib/*.lib $DP/libs/
cp $LO_3RD/lcms2/bin/lcms2.lib $DP/libs/
cp $LO_3RD/nss/dist/out/lib/*.lib $DP/libs/
cp $LO_3RD/liblangtag/liblangtag/.libs/liblangtag.lib $DP/libs/
cp $LO_3RD/libtiff/libtiff/.libs/libtiff.lib $DP/libs/
cp $LO_3RD/libwebp/output/lib/*.lib $DP/libs/
cp $LO_3RD/libxml2/win32/bin.msvc/libxml2.lib $DP/libs/
cp $LO_3RD/curl/builds/libcurl-vc12-x64-release-dll-zlib-static-ipv6-sspi-schannel/lib/libcurl.lib $DP/libs/
mv $DP/libs/iepoxy.lib $DP/libs/epoxy.lib
mv $DP/libs/iskia.lib $DP/libs/skia.lib
mv $DP/libs/ipdfium.lib $DP/libs/pdfium.lib

# copy headers
mkdir -p $DP/inc
rsync -r $LO_3RD/argon2/include/*.h $DP/inc/argon2/
rsync -r $LO_3RD/boost/boost $DP/inc/
rsync -r $LO_3RD/box2d/include/box2d $DP/inc/
rsync -r $LO_3RD/curl/include/curl $DP/inc/
rsync -r $LO_3RD/dragonbox/include/dragonbox $DP/inc/
rsync -r $LO_3RD/dtoa/include/*.h $DP/inc/dtoa/
rsync -r $LO_3RD/epoxy/include/epoxy $DP/inc/
rsync -r $LO_3RD/expat/lib/*.h $DP/inc/expat/
rsync -r $LO_3RD/frozen/include/frozen $DP/inc/
rsync -r $LO_3RD/graphite/include/graphite2 $DP/inc/
rsync -r $LO_3RD/harfbuzz/src/*.h $DP/inc/harfbuzz/
rsync -r $LO_3RD/icu/source/common/unicode $DP/inc/
rsync -r $LO_3RD/icu/source/i18n/unicode $DP/inc/
rsync -r $LO_3RD/icu/source/io/unicode $DP/inc/
rsync -r $LO_3RD/lcms2/include/*.h $DP/inc/lcms2/
rsync -r $LO_3RD/libexttextcat/src/*.h $DP/inc/libexttextcat/
rsync -r $LO_3RD/libjpeg-turbo/*.h $DP/inc/libjpeg-turbo/
rsync -r $LO_3RD/liblangtag/liblangtag/*.h $DP/inc/liblangtag/
rsync -r $LO_3RD/libpng/*.h $DP/inc/libpng/
rsync -r $LO_3RD/libtiff/libtiff/*.h $DP/inc/libtiff/
rsync -r $LO_3RD/libwebp/src/webp $DP/inc/
rsync -r $LO_3RD/libxml2/include/libxml $DP/inc/
rsync -r $LO_3RD/mdds/include/mdds $DP/inc/
rsync -r $LO_3RD/zxcvbn-c/zxcvbn.h $DP/inc/zxcvbn-c/
rsync -r $LO_3RD/zlib/*.h $DP/inc/zlib/
rsync -r $LO_3RD/pdfium/public/ $DP/inc/pdfium/
rsync -r $LO_3RD/nss/dist/public/nss/ $DP/inc/nss/
rsync -r $LO_3RD/nss/dist/out/include/ $DP/inc/nss/

mkdir -p $DP/inc/skia
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/include/ $DP/inc/skia/include/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/tools/ $DP/inc/skia/tools/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/modules/ $DP/inc/skia/modules/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/src/ $DP/inc/skia/src/
