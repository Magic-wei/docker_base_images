ARG UBUNTU_DISTRO
FROM ubuntu:${UBUNTU_DISTRO:-18.04}

ARG DEBIAN_FRONTEND=noninteractive

# Install utility packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        lsb-release \
        git \
        wget \
        curl \
        openssl \
        ca-certificates \
        tar \
        gzip \
        lzip \
        bzip2 \
        xz-utils \
        lzma \
        lzop \
    && rm -rf /var/lib/apt/lists/*

# Install GUI packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libx11-6 \
        libxcb1 \
        libxau6 \
        libgl1-mesa-dev \
        dbus-x11 \
        x11-utils \
        libxkbcommon-x11-0 \
        xvfb \
        mesa-utils \
    && rm -rf /var/lib/apt/lists/*
