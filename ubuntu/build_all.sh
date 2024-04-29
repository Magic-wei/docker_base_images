#!/bin/bash

# Paramter
BUILD_WITH=${1:-origin}

# Build
function build() {
    # ./build.sh 16.04 $1; \
    # ./build.sh 18.04 $1; \
    # ./build.sh 20.04 $1; \
    ./build.sh 22.04 $1; \
    # ./build_gui.sh 16.04 $1; \
    # ./build_gui.sh 18.04 $1; \
    # ./build_gui.sh 20.04 $1; \
    ./build_gui.sh 22.04 $1;
}

build $BUILD_WITH
