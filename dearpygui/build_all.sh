#!/bin/bash

GUI_ENV_NAME_IN=${1:-gui_dev}

function build() {
    ./build.sh 3.9 18.04 $1; \
    ./build.sh 3.9 20.04 $1
}

build $GUI_ENV_NAME_IN
