#!/bin/bash -eux 
set -o pipefail

PYTHON_VERSION='3.10'
JAX_VERSION='0.4.28'
XLA_VERSION='rocm-jaxlib-v0.4.28-qa'
JAXLIB_VERSION='rocm-jaxlib-v0.4.28 '
ALPHAFOLD_VERSION='f251de6'
ARIA2_VERSION='1.36.0'
HHSUITE_VERSION='3.3.0'
OPENMM_VERSION='8.0.0'
OPENMM_HIP_VERSION='e55a3d7'
TENSORFLOW_VERSION='2.16.1'

cat \
  ../common/Dockerfile.header \
  ../common/Dockerfile.rocm-6.2.0  \
  ../common/Dockerfile.miniconda \
  $DOCKERFILE \
  ../common/Dockerfile.jax \
  > $DOCKERFILE_TMP

$DOCKERBUILD \
  -f $DOCKERFILE_TMP \
  --build-arg SERVER_PORT=$SERVER_PORT \
  --build-arg PYTHON_VERSION=$PYTHON_VERSION \
  --build-arg JAX_VERSION=$JAX_VERSION \
  --build-arg XLA_VERSION=$XLA_VERSION \
  --build-arg JAXLIB_VERSION=$JAXLIB_VERSION \
  --build-arg ALPHAFOLD_VERSION=$ALPHAFOLD_VERSION \
  --build-arg ARIA2_VERSION=$ARIA2_VERSION \
  --build-arg HHSUITE_VERSION=$HHSUITE_VERSION \
  --build-arg OPENMM_VERSION=$OPENMM_VERSION \
  --build-arg OPENMM_HIP_VERSION=$OPENMM_HIP_VERSION \
  --build-arg TENSORFLOW_VERSION=$TENSORFLOW_VERSION \
  --progress=plain -t $TAG . 2>&1 | tee $LOG

echo "$TAG" > $RES