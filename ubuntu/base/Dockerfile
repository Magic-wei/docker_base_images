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