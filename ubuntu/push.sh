#!/bin/bash

# Parameters
UBUNTU_DISTRO_IN=${1:-18.04}
IMAGE_TAG=magic4wei/ubuntu:base-${UBUNTU_DISTRO_IN}

# Push to docker.io
docker push ${IMAGE_TAG}