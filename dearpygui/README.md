# DearPyGui Base Images


usage:
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
