#!/bin/env bash

# $1: libcint REF
# $2: internal REF (e.g., latest)

# delete previous attempt if any
rm -Rf libcint/

# clone and checkout
echo "-- Clone"
git clone https://github.com/sunqm/libcint.git
cd libcint/
git checkout ${1}
cd ..

# generate
echo "-- Generate ::"

echo "1) Patching 'licint/':"

# ** Patch generated via:
# git clone https://github.com/sunqm/libcint.git
# cp -r libcint libcint__
# changing stuffs
# diff -ruN libcint__ libcint > generate.patch

patch -p0 < generate.patch

echo "2) Generate C files and corresponding header"
cd libcint/scripts/
cat ../../for-libcint/base_cint_funcs.h > cint_funcs.h
clisp auto_intor.cl >> cint_funcs.h
mv *.c ../src/autocode/
mv cint_funcs.h ../include/
cd ..

echo "4) add Meson files"
cp -R ../for-meson/* .
sed -i "s/#VERSION#/${1}/g" meson.build

# create archive
echo "-- Archive"
tar -czf libcint.tar.gz src/ include/ cmake/ meson.build meson_options.txt CMakeLists.txt

# create wrap
echo "-- Wrap"
HASH=$(sha256sum libcint.tar.gz | cut -d " " -f 1 )
sed -i "s/#REF#/${2}/g" libcint.wrap
sed -i "s/#VERSION#/${1}/g" libcint.wrap
sed -i "s/#HASH#/${HASH}/g" libcint.wrap
