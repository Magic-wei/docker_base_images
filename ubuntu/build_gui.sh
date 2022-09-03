#!/bin/bash

# Parameters
UBUNTU_DISTRO_IN=${1:-18.04}
BUILD_WITH=${2:-origin}
IMAGE_TAG=magic4wei/ubuntu:gui-base-${UBUNTU_DISTRO_IN}

echo "Build: $DOCKERFILE ($BUILD_WITH) -> $IMAGE_TAG"

# Build
case $BUILD_WITH in
    origin) 
            docker build --rm -f gui_base/Dockerfile -t ${IMAGE_TAG} \
            --build-arg UBUNTU_DISTRO=${UBUNTU_DISTRO_IN} \
            .
            ;;
    mirror) 
            docker build --rm -f gui_base/Dockerfile.mirror -t ${IMAGE_TAG}-mirror \
            --build-arg UBUNTU_DISTRO=${UBUNTU_DISTRO_IN} \
            .
            ;;
    *) echo "Choose to build with: origin or mirror (modify apt mirror before apt install)!" && exit 1;;
esac

