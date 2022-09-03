#!/bin/bash

# Paramter
BUILD_WITH=${1:-origin}

# Build
function build() {
    ./build.sh kinetic $1; \
    ./build.sh melodic $1; \
    ./build.sh noetic $1; \
    ./build_gui.sh kinetic $1; \
    ./build_gui.sh melodic $1; \
    ./build_gui.sh noetic $1;
}

build $BUILD_WITH
