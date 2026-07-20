#!/bin/env bash

# run tests for the archive

# check if `generate.sh` as been used first
if [[ ! -f ./libcint/libcint.tar.gz ]]; then
    echo "You should run 'generate.sh' first"
    exit 1
fi

TESTS_DIR="testsdir"

# delete previous attempt if any
rm -Rf ${TESTS_DIR}

# create & go
mkdir ${TESTS_DIR}
cd ${TESTS_DIR}

# Test Meson
for TEST_SOURCE_DIR in ../for-tests/test_meson*; do
    TEST_DIR=$(basename ${TEST_SOURCE_DIR})
    echo "-- Testing ${TEST_DIR}"
    
    # create folder and copy everything in it
    mkdir ${TEST_DIR}
    cp -rv ${TEST_SOURCE_DIR}/* ${TEST_DIR}
    cd ${TEST_DIR}
    
    # also create subproject
    mkdir -p subprojects/libcint
    tar -xzf ../../libcint/libcint.tar.gz -C subprojects/libcint
    
    # build project
    meson setup _build > SETUP.log
    if [[ $? != 0 ]]; then
      cat SETUP.log
      exit 1
      fi
      
    meson compile -C _build > BUILD.log
    if [[ $? != 0 ]]; then
      cat BUILD.log
      exit 1
      fi
    
    # execute
    _build/test_libcint > ACTUAL
    if [[ $(diff EXPECTED ACTUAL) != "" ]]; then
        echo "Unexpected output for ${TEST_DIR}::"
        echo "EXPECTED ---"
        cat EXPECTED
        echo "ACTUAL ----"
        cat ACTUAL
        echo "-----------"
        exit 1
    fi
    
    echo "OK =)"
    # go back
    cd ..
done

# test CMAKE
mkdir test_cmake
echo "-- Testing test_cmake"
cd test_cmake
tar -xzf ../../libcint/libcint.tar.gz
mkdir build
cd build

cmake .. > SETUP.log
if [[ $? != 0 ]]; then
  cat SETUP.log
  exit 1
  fi

cmake --build . -j2 > BUILD.log
if [[ $? != 0 ]]; then
  cat BUILD.log
  exit 1
  fi

echo "OK =)"
cd ..
