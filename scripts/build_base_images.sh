#!/bin/bash

SCRIPT_DIR=$( cd $( dirname $(readlink -f ${BASH_SOURCE[0]}) ) && pwd )
BASE_DIR=$( dirname ${SCRIPT_DIR} )

function build_base() {
    if [ -d $BASE_DIR/$1 ]; then
        echo "Get into '$BASE_DIR/$1' to build!"
        cd $BASE_DIR/$1
        ./build_all.sh
    else
        echo "Base image dir '$BASE_DIR/$1' not exist!"
    fi
}

DIRS=(
ubuntu
ros
miniconda
dearpygui
)

for base_dir in ${DIRS[*]}; do
    build_base $base_dir
done
