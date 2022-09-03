# Same with osrf/ros:${ROS_RELEASE}-desktop-${UBUNTU_DISTRO}
ARG ROS_RELEASE
FROM osrf/ros:${ROS_RELEASE:-melodic}-desktop

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
    && \
    if [ ${ROS_DISTRO} = kinetic ]; then \
        apt-get install -y --no-install-recommends python-catkin-tools; \
    else \
        apt-get install -y --no-install-recommends python3-catkin-tools; \
    fi \
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
