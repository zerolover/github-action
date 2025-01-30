#!/bin/bash
set -e

ROOT=/
LO=/core
DP=/deps
LO_3RD=$LO/workdir/UnpackedTarball

# build dependencies
cd $LO
download='ARGON2 BOOST BOX2D BZIP2 CPPUNIT CURL DRAGONBOX DOTA EPOXY EXPAT FROZEN GRAPHITE HARFBUZZ HUNSPELL HYPHEN
          ICU LCMS2 LIBEXTTEXTCAT LIBFFI LIBJPEG_TURBO LIBLANGTAG LIBPNG LIBTIFF LIBWEBP LIBXML2 MDDS MYTHES NSS
          OPENSSL PDFIUM PYTHON SKIA ZLIB ZXCVBN ZXING'
download=$(echo "$download" | tr '\n' ' ' | tr -s ' ')
sed -i "/download: \$(WORKDIR)\/download/a \fetch_BUILD_TYPE := $download" Makefile.fetch
/opt/lo/bin/make fetch

libraries='argon2 boost box2d bzip2 cppunit curl dragonbox dtoa epoxy expat frozen graphite harfbuzz
           hunspell hyphen icu libjpeg-turbo lcms2 libexttextcat libffi liblangtag libpng libtiff libwebp
           libxml2 mdds mythes nss openssl pdfium python3 zxcvbn-c skia zlib'
echo '$(eval $(call gb_Module_Module,external))' > $LO/external/Module_external.mk
echo '$(eval $(call gb_Module_add_moduledirs,external,'$libraries'))' >> $LO/external/Module_external.mk
/opt/lo/bin/make solenv StaticLibrary_ulingu external sal

# debug
ls -alhd $LO/workdir/UnpackedTarball/*/
ls -alh $LO/instdir/program/

# copy libraries
cd $ROOT
mkdir -p $DP/libs
cp $LO/instdir/program/*.dll $DP/libs/
cp $LO/workdir/LinkTarget/Library/*.lib $DP/libs/
cp $LO/workdir/LinkTarget/StaticLibrary/*.lib $DP/libs/

cp $LO_3RD/argon2/vs2015/build/Argon2OptDll.lib $DP/libs/
cp $LO_3RD/curl/builds/libcurl-vc12-x64-release-dll-zlib-static-ipv6-sspi-schannel/lib/libcurl.lib $DP/libs/
cp $LO_3RD/harfbuzz/src/.libs/libharfbuzz.lib $DP/libs/
cp $LO_3RD/icu/source/lib/*.dll $DP/libs/
cp $LO_3RD/icu/source/lib/*.lib $DP/libs/
cp $LO_3RD/lcms2/bin/lcms2.lib $DP/libs/
cp $LO_3RD/liblangtag/liblangtag/.libs/liblangtag.lib $DP/libs/
cp $LO_3RD/libtiff/libtiff/.libs/libtiff.lib $DP/libs/
cp $LO_3RD/libwebp/output/lib/*.lib $DP/libs/
cp $LO_3RD/libxml2/win32/bin.msvc/libxml2.lib $DP/libs/
cp $LO_3RD/nss/dist/out/lib/*.lib $DP/libs/

mv $DP/libs/hyphen.lib $DP/libs/libhyphen.a.lib
mv $DP/libs/iepoxy.lib $DP/libs/epoxy.lib
mv $DP/libs/ipdfium.lib $DP/libs/pdfium.lib
mv $DP/libs/iskia.lib $DP/libs/skia.lib

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
rsync -r $LO_3RD/hunspell/src/hunspell/*.h* $DP/inc/hunspell/
rsync -r $LO_3RD/hyphen/*.h $DP/inc/hyphen/
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
rsync -r $LO_3RD/mythes/*.hxx $DP/inc/mythes/
rsync -r $LO_3RD/nss/dist/out/include/ $DP/inc/nss/
rsync -r $LO_3RD/nss/dist/public/nss/ $DP/inc/nss/
rsync -r $LO_3RD/pdfium/public/ $DP/inc/pdfium/
rsync -r $LO_3RD/zlib/*.h $DP/inc/zlib/
rsync -r $LO_3RD/zxcvbn-c/zxcvbn.h $DP/inc/zxcvbn-c/

mkdir -p $DP/inc/skia
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/include/ $DP/inc/skia/include/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/modules/ $DP/inc/skia/modules/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/src/ $DP/inc/skia/src/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/tools/ $DP/inc/skia/tools/

# copy binaries
mkdir -p $DP/bin
cp $LO_3RD/icu/source/bin/genbrk.exe $DP/bin/
cp $LO_3RD/icu/source/bin/genccode.exe $DP/bin/
cp $LO_3RD/icu/source/bin/gencmn.exe $DP/bin/

# copy share
mkdir -p $DP/share/liblangtag
rsync -r $LO_3RD/liblangtag/data/*.xml $DP/share/liblangtag/
rsync -r $LO_3RD/liblangtag/data/common $DP/share/liblangtag/
