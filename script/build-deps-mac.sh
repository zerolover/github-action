#!/bin/bash
set -e

ROOT="$PWD"
LO=$ROOT/core
DP=$ROOT/deps
LO_3RD=$LO/workdir/UnpackedTarball

# build dependencies
cd $LO
gsed -i '/gb_Library_use_libraries/,+2d' external/skia/Library_skia.mk
download='ARGON2 BOOST BOX2D BZIP2 CPPUNIT CURL DRAGONBOX DOTA EPOXY EXPAT FROZEN GRAPHITE HARFBUZZ HUNSPELL HYPHEN
          ICU LCMS2 LIBEXTTEXTCAT LIBFFI LIBJPEG_TURBO LIBLANGTAG LIBPNG LIBTIFF LIBWEBP LIBXML2 MDDS MYTHES NSS
          OPENSSL PDFIUM PYTHON SKIA ZLIB ZXCVBN ZXING'
download=$(echo "$download" | tr '\n' ' ' | tr -s ' ')
gsed -i "/download: \$(WORKDIR)\/download/a \fetch_BUILD_TYPE := $download" Makefile.fetch
./autogen.sh --without-java --without-doxygen --without-help --without-fonts --disable-online-update --enable-bogus-pkg-config
make fetch

libraries='argon2 boost box2d cppunit curl dragonbox dtoa epoxy expat frozen graphite harfbuzz
           hunspell hyphen icu libjpeg-turbo lcms2 libexttextcat liblangtag libpng libtiff libwebp
           mdds mythes nss openssl pdfium zxcvbn-c skia'
echo '$(eval $(call gb_Module_Module,external))' > $LO/external/Module_external.mk
echo '$(eval $(call gb_Module_add_moduledirs,external,'$libraries'))' >> $LO/external/Module_external.mk
make solenv StaticLibrary_ulingu external sal

# debug
ls -alhd $LO/workdir/UnpackedTarball/*/
ls -alh $LO/instdir/LibreOfficeDev.app/Contents/Frameworks/

# copy libraries
cd $ROOT
mkdir -p $DP/libs

cp -a $LO_3RD/argon2/libargon2.a $DP/libs/
cp -a $LO_3RD/curl/lib/.libs/lib*.dylib* $DP/libs/
cp -a $LO_3RD/harfbuzz/src/.libs/libharfbuzz.a $DP/libs/
cp -a $LO_3RD/hunspell/src/hunspell/.libs/libhunspell*.a $DP/libs/libhunspell.a
cp -a $LO_3RD/hyphen/.libs/libhyphen.a $DP/libs/
cp -a $LO_3RD/icu/source/lib/lib*.dylib* $DP/libs/
cp -a $LO_3RD/lcms2/src/.libs/lib*.dylib* $DP/libs/
cp -a $LO_3RD/libexttextcat/src/.libs/libexttextcat-2.0.a $DP/libs/
cp -a $LO_3RD/liblangtag/liblangtag/.libs/liblangtag*.dylib* $DP/libs/
cp -a $LO_3RD/libtiff/libtiff/.libs/libtiff.a $DP/libs/
cp -a $LO_3RD/libwebp/sharpyuv/.libs/libsharpyuv.a $DP/libs/
cp -a $LO_3RD/libwebp/src/.libs/libwebp.a $DP/libs/
cp -a $LO_3RD/mythes/.libs/libmythes*.a $DP/libs/libmythes.a
cp -a $LO_3RD/nss/dist/out/lib/*.dylib $DP/libs/

cp $LO/instdir/LibreOfficeDev.app/Contents/Frameworks/libuno_sal.dylib* $DP/libs/
cp $LO/instdir/LibreOfficeDev.app/Contents/Frameworks/libpdfiumlo.dylib $DP/libs/
cp $LO/instdir/LibreOfficeDev.app/Contents/Frameworks/libskialo.dylib $DP/libs/
cp $LO/instdir/LibreOfficeDev.app/Contents/Frameworks/libepoxy.dylib $DP/libs/
cp $LO/workdir/LinkTarget/StaticLibrary/lib*.a $DP/libs/
chmod +x $DP/libs/*dylib*

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
rsync -r $LO_3RD/mdds/include/mdds $DP/inc/
rsync -r $LO_3RD/mythes/*.hxx $DP/inc/mythes/
rsync -r $LO_3RD/nss/dist/out/include/ $DP/inc/nss/
rsync -r $LO_3RD/nss/dist/public/nss/ $DP/inc/nss/
rsync -r $LO_3RD/pdfium/public/ $DP/inc/pdfium/
rsync -r $LO_3RD/zxcvbn-c/zxcvbn.h $DP/inc/zxcvbn-c/

mkdir -p $DP/inc/skia
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/include/ $DP/inc/skia/include/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/modules/ $DP/inc/skia/modules/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/src/ $DP/inc/skia/src/
rsync -r --include='*/' --include='*.h' --exclude='*' $LO_3RD/skia/tools/ $DP/inc/skia/tools/

# copy binaries
mkdir -p $DP/bin
cp -a $LO_3RD/icu/source/bin/genbrk $DP/bin/
cp -a $LO_3RD/icu/source/bin/genccode $DP/bin/
cp -a $LO_3RD/icu/source/bin/gencmn $DP/bin/

# copy share
mkdir -p $DP/share/liblangtag
rsync -r $LO_3RD/liblangtag/data/*.xml $DP/share/liblangtag/
rsync -r $LO_3RD/liblangtag/data/common $DP/share/liblangtag/
