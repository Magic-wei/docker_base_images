ARG UBUNTU_DISTRO
FROM ubuntu:${UBUNTU_DISTRO:-18.04}

# Update source
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --no-install-recommends wget openssl ca-certificates -y && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda and initialize
ARG MINICONDA_VERSION=latest
ENV MINICONDA_DIR="/opt/anaconda/Miniconda3"
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh && \
    chmod +x miniconda.sh && \
    ./miniconda.sh -b -p $MINICONDA_DIR && \
    rm miniconda.sh && \
    $MINICONDA_DIR/bin/conda init && \
    $MINICONDA_DIR/bin/conda clean -afy

CMD ["/bin/bash"]
