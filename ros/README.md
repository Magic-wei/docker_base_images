# ROS Base Images

Install utility packages for more convenient development and test:
- Utils: apt-utils, lsb-release, ca-certificates openssl
- Download files: git, wget, curl
- Archive, compress and uncompress: tar, gzip, lzip. bzip2. xz-utils, lzma, lzop

## Manage Package Repositories

Add APT repository mirrors:
```shell
# Tsinghua
sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

ROS mirrors configuration:
- [aliyun ROS1](https://developer.aliyun.com/mirror/ros)
- [aliyun ROS2](https://developer.aliyun.com/mirror/ros2)
- [tuna ROS1](https://mirrors.tuna.tsinghua.edu.cn/help/ros/)
- [tuna ROS2](https://mirrors.tuna.tsinghua.edu.cn/help/ros2/)

Original ROS source list:
```shell
# osrf/ros:kinetic-desktop
cat /etc/apt/sources.list.d/ros1-snapshots.list
# kinetic - Ubuntu 16.04: deb http://snapshots.ros.org/kinetic/final/ubuntu xenial main

# osrf/ros:melodic-desktop, osrf/ros:noetic-desktop
cat /etc/apt/sources.list.d/ros1-latest.list
# melodic - Ubuntu 18.04: deb http://packages.ros.org/ros/ubuntu bionic main
# Noetic - Ubuntu 20.04: deb http://packages.ros.org/ros/ubuntu focal main
```

## Build and Push

I personally manage base images with commands below, you can modify them for your purposes.

```shell
# Build
./build.sh [<ros-distro> [origin/mirror]]
./build_gui.sh [<ros-distro> [origin/mirror]] # build GUI base images
./build.sh melodic # melodic by default if no argument is given
./build.sh melodic mirror # download from additional source list, use `origin` with default source list
./build_all.sh [origin/mirror] # build all base images based on ubuntu 16.04, 18.04 and 20.04

# Push
./push.sh [<ros-distro>] # default is melodic
./push_gui.sh [<ros-distro>] # push GUI base images
./push_all.sh # push all built ubuntu base images
```

## Usage

### Explore ROS Base Images

ROS base images all have an entrypoint script located at `/ros_entrypoint.sh`:

```shell
#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
exec "$@"
```

This entrypoint allows us to execute successive commands after ros environment setup.


Explore more about base images by running

```shell
# ROS Melodic for example
docker run -it --rm magic4wei/ros:melodic-desktop-bionic  # no OpenGL rendering is supported
docker run -it --rm magic4wei/ros:melodic-desktop-bionic-gui  # enable OpenGL rendering, see tutorial below
```

### Work with OpenGL Rendering

Base image `magic4wei/ros:*-gui` have already installed required packages to enable OpenGL rendering in container. Before you go through this tutorial, make sure that
- at least one GPU is mounted on your machine
- GPU driver is installed correctly
- You can run `glxgears` in terminal without any error (package `mesa-utils` is needed)

**Firstly, you need to run `xhost +` on your host machine to enable X client display.**

For Intel GPU, simply run

```shell
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
--device=/dev/dri:/dev/dri \
magic4wei/ros:melodic-desktop-bionic-gui
```

For Nvidia GPU, it is a little more complicated. We need to connect Nvidia driver volume when docker image runs, and add Nvidia OpenGL library path to `LD_LIBRARY_PATH` inside the container. If you want to run Nvidia executable tools like `nvidia-smi`, you also need to add their path to `PATH` inside the container.

For example, I have installed Nvidia driver `nvidia-430` at `/usr/lib/nvidia-430` and `/usr/lib32/nvidia-430` (32-bit compatible libraries), and all my Nvidia tools are located at `/usr/lib/nvidia-430/bin`. Two steps to enable OpenGL rendering in container:

1. Run image with Nvidia driver volume bindings
```shell
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v /usr/lib/nvidia-430:/usr/hostLib/lib/nvidia \
-v /usr/lib32/nvidia-430:/usr/hostLib/lib32/nvidia \
magic4wei/ros:melodic-desktop-bionic-gui
```
2. Add Nvidia OpenGL library path in the container
```shell
export LD_LIBRARY_PATH=/usr/hostLib/lib/nvidia:/usr/hostLib/lib32/nvidia:${LD_LIBRARY_PATH} # required for OpenGL rendering
export PATH=/usr/hostLib/lib/nvidia/bin:${PATH} # optional, add this if you want to run tools like nvidia-smi
```

Then you are able to run `Rviz` or other GUI applications that requires OpenGL rendering in the container. For example,

```shell
# Example 1: Run Rviz
roscore & rviz

# Example 2: Run glxgears (needs `mesa-utils`, already installed in GUI base images)
glxgears
```
