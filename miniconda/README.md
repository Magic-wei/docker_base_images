# Miniconda Base Images

Install latest Miniconda version.

usage:
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
