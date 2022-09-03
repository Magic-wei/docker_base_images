#!/bin/bash

# Parameters
UBUNTU_DISTRO_IN=${1:-18.04}
MINICONDA_VERSION_IN=${2:-latest}
BUILD_WITH=${3:-origin}
IMAGE_TAG=magic4wei/miniconda:miniconda3-${MINICONDA_VERSION_IN}-ubuntu${UBUNTU_DISTRO_IN}-gui

echo "Build Miniconda (GUI): $DOCKERFILE - $UBUNTU_DISTRO_IN - $MINICONDA_VERSION_IN"

# Build
cp miniconda_entrypoint.sh gui_base/
case $BUILD_WITH in
    origin) 
            docker build --rm -f gui_base/Dockerfile -t ${IMAGE_TAG} \
            --build-arg UBUNTU_DISTRO=${UBUNTU_DISTRO_IN} \
            --build-arg MINICONDA_VERSION=${MINICONDA_VERSION_IN} \
            .
            ;;
    mirror) 
            docker build --rm -f gui_base/Dockerfile.mirror -t ${IMAGE_TAG}-mirror \
            --build-arg UBUNTU_DISTRO=${UBUNTU_DISTRO_IN} \
            --build-arg MINICONDA_VERSION=${MINICONDA_VERSION_IN} \
            .
            ;;
    *) echo "Choose to build with: origin or mirror (modify apt mirror before apt install)!" && exit 1;;
esac
rm gui_base/miniconda_entrypoint.sh