#!/bin/sh

IMAGE_NAME="$1"
IMAGE_TAG="$2"
BASE_IMAGE="$3"
BASE_TAG="$4"
BUILD_COMMAND="$5"

# exit on error
set -e

error() {
  exit 1
}


if [ -f "./Dockerfile" ]; then
    echo "Using existing Dockerfile from notebook repository."
else 
    echo "Using default Dockerfile from action repository."
    cp /notebook-Dockerfile ./Dockerfile || error
fi

echo "Building container image with name $IMAGE_NAME:$IMAGE_TAG"
docker build . -t "$IMAGE_NAME:$IMAGE_TAG" --build-arg baseimage="$BASE_IMAGE" --build-arg basetag="$BASE_TAG" --build-arg buildcommand="$BUILD_COMMAND" || error
