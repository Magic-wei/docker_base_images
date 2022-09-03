#!/bin/bash
set -e

# setup conda environment
. /opt/miniconda/miniconda3/etc/profile.d/conda.sh --
exec "$@"