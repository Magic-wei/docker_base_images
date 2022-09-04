# DearPyGui Base Images

## Build and Push

I personally manage base images with commands below, you can modify them for your purposes.

```shell
# Build
./build.sh [<python-distro> [<ubuntu-distro> [<gui-env-name>]]]
./build_gui.sh [<python-distro> [<ubuntu-distro> [<gui-env-name>]]] # build GUI base images
./build.sh 3.9 18.04 my_gui_dev # Customize Conda env name as `my_gui_dev`
./build_all.sh # build all base images based on ubuntu 18.04 and 20.04

# Push
./push.sh [<python-distro> [<ubuntu-distro>]] # default is 3.9 18.04
./push_gui.sh [<python-distro> [<ubuntu-distro>]] # push GUI base images
./push_all.sh # push all built ubuntu base images
```

## Usage

You can pull DeraPyGui base images from [magic4wei/dearpygui](https://hub.docker.com/r/magic4wei/dearpygui) or build with scripts in this directory.

### Explore DearPyGui Base Images

DearPyGui base images are built from Miniconda base image `magic4wei/miniconda:*-gui`. A new conda environment is created to install required Python version and DearPyGui package. By default, the name of the new conda environment is `gui_dev`.

Everything else is identical to the Miniconda base image `magic4wei/miniconda:miniconda3-latest-ubuntu<XX>.04-gui` (see [magic4wei/miniconda](https://hub.docker.com/r/magic4wei/miniconda)).

Explore DearPyGui base images by running

```shell
docker run -it --rm magic4wei/dearpygui:base-py3.9-ubuntu18.04
docker run -it --rm magic4wei/dearpygui:base-py3.9-ubuntu20.04
```

### Work with OpenGL Rendering

DearPyGui requires OpenGL rendering.

Before you go through this tutorial, make sure that
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
magic4wei/dearpygui:base-py3.9-ubuntu18.04
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
magic4wei/dearpygui:base-py3.9-ubuntu18.04
```
2. Add Nvidia OpenGL library path in the container
```shell
export LD_LIBRARY_PATH=/usr/hostLib/lib/nvidia:/usr/hostLib/lib32/nvidia:${LD_LIBRARY_PATH} # required for OpenGL rendering
export PATH=/usr/hostLib/lib/nvidia/bin:${PATH} # optional, add this if you want to run tools like nvidia-smi
```

Then you are able to run DearPyGui or other GUI applications that requires OpenGL rendering in the container. For example,

```shell
# Example: Run glxgears (needs `mesa-utils`, already installed in GUI base images)
glxgears
```
