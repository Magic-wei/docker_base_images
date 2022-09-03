#!/bin/bash

# Parameters
PYTHON_VERSION_IN=${1:-3.9}
UBUNTU_DISTRO_IN=${2:-18.04}
GUI_ENV_NAME_IN=${3:-gui_dev}
IMAGE_TAG=magic4wei/dearpygui:base-py${PYTHON_VERSION_IN}-ubuntu${UBUNTU_DISTRO_IN}

# Build
docker build --rm -f Dockerfile -t ${IMAGE_TAG} \
--build-arg UBUNTU_DISTRO=${UBUNTU_DISTRO_IN} \
--build-arg PYTHON_VERSION=${PYTHON_VERSION_IN} \
--build-arg GUI_ENV_NAME=${GUI_ENV_NAME_IN} \
.