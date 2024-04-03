#!/bin/env bash

# to be executed in the root directory of libcint

echo "Patching 'scripts/auto_intor.cl' in ${PWD}"

# add <i|-i\nabla|j>
sed -i "10i  '(\"int1e_p\"                   ( \\\\| p ))" scripts/auto_intor.cl

echo "... Patched!"

echo "Generate"
cd scripts/
clisp auto_intor.cl
mv *.c ../src/autocode/
cd ..

echo "add Meson files"
cp -R ../meson/* .

echo "done"
