ARG BASE_IMAGE=unsloth/unsloth:latest
FROM ${BASE_IMAGE}

# Switch to root for package installation
USER root

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ollama
RUN wget -qO - https://ollama.com/install.sh | bash

# Install application packages without overriding Unsloth's curated ML stack
RUN pip install --no-cache-dir pandas sqlalchemy ollama

USER unsloth

# Use the upstream workspace layout
WORKDIR /workspace/work

ENV OLLAMA_MODELS=/home/unsloth/.ollama/models

# Start the container with an endless running task
CMD [ "/bin/sh", "-c", "tail -f /dev/null" ]
