#!/bin/bash

# Parameters
PYTHON_VERSION_IN=${1:-3.9}
UBUNTU_DISTRO_IN=${2:-18.04}
IMAGE_TAG=magic4wei/dearpygui:base-py${PYTHON_VERSION_IN}-ubuntu${UBUNTU_DISTRO_IN}

# Push to docker.io
docker push ${IMAGE_TAG}