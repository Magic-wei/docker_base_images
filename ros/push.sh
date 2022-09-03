#!/bin/bash

# Parameters
ROS_RELEASE_IN=${1:-melodic}
case $ROS_RELEASE_IN in
    kinetic) UBUNTU_DISTRO=xenial ;;        
    melodic) UBUNTU_DISTRO=bionic ;;
    noetic) UBUNTU_DISTRO=focal ;;
    *) echo "Currently not support ${ROS_RELEASE_IN} in this build script!" && exit 1;;
esac

IMAGE_TAG=magic4wei/ros:${ROS_RELEASE_IN}-desktop-${UBUNTU_DISTRO}

echo "Push: $IMAGE_TAG"

# Push to docker.io
docker push ${IMAGE_TAG}