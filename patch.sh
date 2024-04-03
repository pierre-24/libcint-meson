#!/bin/env bash

# to be executed in the root directory of libcint

echo "Patching 'scripts/auto_intor.cl' in ${PWD}"

# remove comments
sed -i "s/;'(\"int1e_ovlp/'(\"int1e_ovlp/g" scripts/auto_intor.cl
sed -i "s/;'(\"int1e_nuc/'(\"int1e_nuc/g" scripts/auto_intor.cl

# add <i|-i\nabla|j>
sed -i "10i  '(\"int1e_p\"                   ( \\\\| p ))" scripts/auto_intor.cl

echo "... Patched!"

echo "Generate"
cd scripts/
clisp auto_intor.cl

echo "Move generated code"
mv *.c ../src/autocode/

echo "done"
