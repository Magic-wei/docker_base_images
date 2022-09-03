# ROS Base Images

Install utility packages for more convenient development and test:
- Utils: apt-utils, lsb-release
- Download files: git, wget, curl
- Archive, compress and uncompress: tar, gzip, lzip. bzip2. xz-utils, lzma, lzop

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

usage:
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
