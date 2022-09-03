# Docker Base Images

This directory contains dockerfiles to build base images that I frequently use, including
- [ubuntu](./ubuntu/) (w/ gui) for general purposes
- [ros](./ros/) (w/ gui) for ROS applications
- [miniconda](./miniconda/) (w/ gui) for Python applications
- [dearpygui](./dearpygui/) for DearPyGui applications

## Run Applications that Require OpenGL Rendering

Get started with the following base images If you want to run a GUI application that requires OpenGL rendering:

- `magic4wei/ubuntu:gui-base-*` as Ubuntu base image
- `magic4wei/ros:*-gui` as ROS base image
- `magic4wei/miniconda:*-gui` as Miniconda base image

See README file in each directory for more details.

## Pull from Docker Hub

You can pull these Docker images from Docker Hub:

- [magic4wei/ubuntu](https://hub.docker.com/r/magic4wei/ubuntu)
- [magic4wei/ros](https://hub.docker.com/r/magic4wei/ros)
- [magic4wei/miniconda](https://hub.docker.com/r/magic4wei/miniconda)
- [magic4wei/dearpygui](https://hub.docker.com/r/magic4wei/dearpygui)
