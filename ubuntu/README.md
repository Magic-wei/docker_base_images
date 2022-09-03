# Ubuntu Base Images

Install packages for more convenient development and test:
- Utils: apt-utils, lsb-release, ca-certificates openssl
- Download files: git, wget, curl
- Archive, compress and uncompress: tar, gzip, lzip. bzip2. xz-utils, lzma, lzop

Add APT repository mirrors with the following commands if you need to speed up `apt` downloading in China:
```shell
# Tsinghua
sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

usage:
```shell
# Build
./build.sh [<ubuntu-distro> [origin/mirror]]
./build_gui.sh [<ubuntu-distro> [origin/mirror]] # build GUI base images
./build.sh 18.04 # 18.04 by default if no argument is given
./build.sh 18.04 mirror # download from additional source list, use `origin` with default source list
./build_all.sh [origin/mirror] # build all base images based on ubuntu 16.04, 18.04 and 20.04

# Push
./push.sh [<ubuntu-distro>] # default is 18.04
./push_gui.sh [<ubuntu-distro>] # push GUI base images
./push_all.sh # push all built ubuntu base images
```
