#!/bin/bash

# Parameters
UBUNTU_DISTRO_IN=${1:-18.04}
MINICONDA_VERSION_IN=${2:-latest}
IMAGE_TAG=magic4wei/miniconda:miniconda3-${MINICONDA_VERSION_IN}-ubuntu${UBUNTU_DISTRO_IN}-gui

# Push to docker.io
docker push ${IMAGE_TAG}
