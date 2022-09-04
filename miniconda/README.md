# Miniconda Base Images

## Installed Packages

Install latest Miniconda version.

- [`base/Dockerfile`](base/Dockerfile): installed wget, openssl, ca-certificates and Miniconda3.
- [`gui_base/Dockerfile`](gui_base/Dockerfile): built from [`magic4wei/ubuntu:gui-base-*`](https://hub.docker.com/r/magic4wei/ubuntu) and installed Miniconda3. See [ubuntu README](../ubuntu/README.md) for more details about installed packages.

## Build and Push

I personally manage base images with commands below, you can modify them for your purposes.

```shell
# Build
./build.sh [<ubuntu-distro> [<miniconda-version> [origin/mirror]]]
./build_gui.sh [<ubuntu-distro> [<miniconda-version> [origin/mirror]]] # build GUI base images
./build.sh 18.04 # 18.04, latest by default if no argument is given
./build.sh 18.04 latest mirror # download from additional source list, use `origin` with default source list
./build_all.sh [origin/mirror] # build all base images based on ubuntu 18.04 and 20.04

# Push
./push.sh [<ubuntu-distro> [<miniconda-version>]] # default is 18.04 latest
./push_gui.sh [<ubuntu-distro> [<miniconda-version>]] # push GUI base images
./push_all.sh # push all built ubuntu base images
```

## Usage

You can pull Miniconda base images from [magic4wei/miniconda](https://hub.docker.com/r/magic4wei/miniconda) or build with scripts in this directory.

### Explore Miniconda Base Images

Get started with base image `magic4wei/miniconda:miniconda3-<XXXXXX>-ubuntu<XX>.04-gui` If you want to run a GUI application that requires OpenGL rendering (see tutorial below). Otherwise `magic4wei/miniconda:miniconda3-<XXXXXX>-ubuntu<XX>.04` would be better since it has smaller size.

Explore Miniconda base images by running

```shell
# Ubuntu 18.04 for example
docker run -it --rm magic4wei/miniconda:miniconda3-latest-ubuntu18.04  # no OpenGL rendering is supported
docker run -it --rm magic4wei/miniconda:miniconda3-latest-ubuntu18.04-gui  # enable OpenGL rendering, see tutorial below
```

### Work with OpenGL Rendering

Base image `magic4wei/miniconda:*-gui` have already installed required packages to enable OpenGL rendering in container. Before you go through this tutorial, make sure that
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
magic4wei/miniconda:miniconda3-latest-ubuntu18.04-gui
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
magic4wei/miniconda:miniconda3-latest-ubuntu18.04-gui
```
2. Add Nvidia OpenGL library path in the container
```shell
export LD_LIBRARY_PATH=/usr/hostLib/lib/nvidia:/usr/hostLib/lib32/nvidia:${LD_LIBRARY_PATH} # required for OpenGL rendering
export PATH=/usr/hostLib/lib/nvidia/bin:${PATH} # optional, add this if you want to run tools like nvidia-smi
```

Then you are able to run GUI applications that requires OpenGL rendering in the container. For example,

```shell
# Example: Run glxgears (needs `mesa-utils`, already installed in GUI base images)
glxgears
```
