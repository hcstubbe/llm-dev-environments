ARG BASE_IMAGE=unsloth/unsloth:latest
FROM ${BASE_IMAGE}

# Switch to root for package installation
USER root

# Install only the extra system tools this derived image actually needs
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Unsloth already ships the Ollama binary. Only add the Python packages we need.
RUN pip install --no-cache-dir pandas sqlalchemy ollama

USER unsloth

# Use the upstream workspace layout
WORKDIR /workspace/work

ENV OLLAMA_MODELS=/home/unsloth/.ollama/models

# Start the container with an endless running task
CMD [ "/bin/sh", "-c", "tail -f /dev/null" ]
