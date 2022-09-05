#!/bin/bash
set -e

# setup conda environment
. ${MINICONDA_DIR}/etc/profile.d/conda.sh --
"$@"