#!/bin/bash

# Script to build, tag, and push a Docker image for ollama_unsloth with PyTorch.

# Example usage:
# bash create_image.bash <version> <owner> [options]
# <version> - The version of the image to be built (e.g., 1.0.0)
# <owner> - The Docker Hub username or organization name (e.g., myusername)
# [options] - Additional options to pass to the docker build command (e.g., --no-cache)
# This script builds a Docker image for ollama_unsloth with PyTorch, tags it, and pushes it to Docker Hub.

# Input arguments
VERSION=$1
OWNER=$2
OPTIONS=$3

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
docker build $OPTIONS -t $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION -f Dockerfile .
if [ $? -ne 0 ]; then
  echo "Error: Docker build failed."
  exit 1
fi

# Tag the image as 'latest'
echo "Tagging Docker image as 'latest'..."
docker tag $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest
if [ $? -ne 0 ]; then
  echo "Error: Docker tag failed."
  exit 1
fi

# Push the versioned image
echo "Pushing versioned Docker image..."
docker push $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION
if [ $? -ne 0 ]; then
  echo "Error: Docker push for versioned image failed."
  exit 1
fi

# Push the 'latest' image
echo "Pushing 'latest' Docker image..."
docker push $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest
if [ $? -ne 0 ]; then
  echo "Error: Docker push for 'latest' image failed."
  exit 1
fi

echo "Docker image build, tag, and push completed successfully."