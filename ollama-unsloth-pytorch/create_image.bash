#!/bin/bash

set -euo pipefail

# Script to build, tag, and push a Docker image for ollama_unsloth with PyTorch.

# Example usage:
# bash create_image.bash <version> <owner> [options]
# <version> - The version of the image to be built (e.g., 1.0.0)
# <owner> - The Docker Hub username or organization name (e.g., myusername)
# [options] - Additional options to pass to the docker build command (e.g., --no-cache)
# This script builds a Docker image for ollama_unsloth with PyTorch, tags it, and pushes it to Docker Hub.

# Input arguments
VERSION=${1:-}
OWNER=${2:-}

if [ "$#" -ge 2 ]; then
  shift 2
else
  shift $#
fi

BUILD_ARGS=("$@")
IMAGE_REF="$OWNER/ollama_unsloth"

push_with_retry() {
  local image_ref=$1
  local max_attempts=${PUSH_RETRIES:-5}
  local delay=${PUSH_RETRY_DELAY:-30}
  local attempt=1

  while [ "$attempt" -le "$max_attempts" ]; do
    echo "Pushing $image_ref (attempt $attempt/$max_attempts) ..."
    if docker push "$image_ref"; then
      return 0
    fi

    if [ "$attempt" -eq "$max_attempts" ]; then
      echo "Error: Docker push failed for $image_ref after $max_attempts attempts."
      return 1
    fi

    echo "Push failed for $image_ref. Retrying in ${delay}s ..."
    sleep "$delay"
    attempt=$((attempt + 1))
    delay=$((delay * 2))
  done
}

# Check if VERSION is provided
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version> <owner> [options]"
  exit 1
fi

# Check if OWNER is provided
if [ -z "$OWNER" ]; then
  echo "Error: OWNER is required."
  echo "Usage: $0 <version> <owner> [options]"
  exit 1
fi

# Build the Docker image
echo "Building Docker image version $VERSION ..."
docker build "${BUILD_ARGS[@]}" -t $IMAGE_REF:$VERSION -f Dockerfile .

# Tag the image as 'latest'
echo "Tagging Docker image as 'latest'..."
docker tag $IMAGE_REF:$VERSION $IMAGE_REF:latest

# Push the versioned image
push_with_retry $IMAGE_REF:$VERSION

# Push the 'latest' image
push_with_retry $IMAGE_REF:latest

echo "Docker image build, tag, and push completed successfully."