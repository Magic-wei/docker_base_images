#!/bin/bash

# Parameters
ROS_RELEASE_IN=${1:-melodic}
BUILD_WITH=${2:-origin}
case $ROS_RELEASE_IN in
    kinetic) UBUNTU_DISTRO=xenial ;;        
    melodic) UBUNTU_DISTRO=bionic ;;
    noetic) UBUNTU_DISTRO=focal ;;
    *) echo "Currently not support ${ROS_RELEASE_IN} in this build script!" && exit 1;;
esac

IMAGE_TAG=magic4wei/ros:${ROS_RELEASE_IN}-desktop-${UBUNTU_DISTRO}-gui

echo "Building: $ROS_RELEASE_IN - $UBUNTU_DISTRO"

# Build
case $BUILD_WITH in
    origin) 
            docker build --rm -f gui_base/Dockerfile -t ${IMAGE_TAG} \
            --build-arg ROS_RELEASE=${ROS_RELEASE_IN} \
            .
            ;;
    mirror) 
            docker build --rm -f gui_base/Dockerfile.mirror -t ${IMAGE_TAG}-mirror \
            --build-arg ROS_RELEASE=${ROS_RELEASE_IN} \
            .
            ;;
    *) echo "Choose to build with: origin or mirror (modify apt mirror before apt install)!" && exit 1;;
esac