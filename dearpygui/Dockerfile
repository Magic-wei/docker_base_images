ARG UBUNTU_DISTRO
FROM magic4wei/miniconda:miniconda3-latest-ubuntu${UBUNTU_DISTRO:-18.04}-gui

ARG PYTHON_VERSION
ARG GUI_ENV_NAME

ENV GUI_ENV_NAME=${GUI_ENV_NAME:-gui_dev}

# Configure virtual environment for GUI dev
RUN . $MINICONDA_DIR/etc/profile.d/conda.sh && \
    conda create --name ${GUI_ENV_NAME} python=${PYTHON_VERSION:-3.9} -y && \
    conda activate ${GUI_ENV_NAME} && \
    pip install --upgrade pip && \
    $MINICONDA_DIR/bin/conda clean -afy

# Install DearPyGui
RUN . $MINICONDA_DIR/etc/profile.d/conda.sh && \
    conda activate ${GUI_ENV_NAME} && \
    pip install dearpygui && \
    $MINICONDA_DIR/bin/conda clean -afy
