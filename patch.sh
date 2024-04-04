#!/bin/env bash

# to be executed in the root directory of libcint

echo "Patching 'scripts/auto_intor.cl' in ${PWD}"

# add <i|-i\nabla|j>
sed -i "10i  '(\"int1e_p\"                   ( \\\\| p ))" scripts/auto_intor.cl

echo "... Patched!"

echo "Generate C files and corresponding header"
cd scripts/
cat ../../for-libcint/base_cint_funcs.h > cint_funcs.h
clisp auto_intor.cl >> cint_funcs.h
mv *.c ../src/autocode/
mv cint_funcs.h ../include/
cd ..

echo "add Meson files"
cp -R ../for-meson/* .

echo "done"
