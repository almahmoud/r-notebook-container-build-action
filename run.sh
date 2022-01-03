#!/bin/bash

IMAGE_NAME="$1"
IMAGE_TAG="$2"
BASE_IMAGE="$3"
BASE_TAG="$4"

# exit on error
set -ex

error() {
  exit 1
}


if [ -f "./Dockerfile" ]; then
    echo "Using existing Dockerfile from notebook repository."
else 
    cp /notebook-Dockerfile ./Dockerfile || error
    echo "Using default Dockerfile from action repository."
fi

echo "Building container image with name $IMAGE_NAME:$IMAGE_TAG"
docker build . -t "$IMAGE_NAME:$IMAGE_TAG" --build-arg baseimage="$BASE_IMAGE" --build-arg basetag="$BASE_TAG" || error
