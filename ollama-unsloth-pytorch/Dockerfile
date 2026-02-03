FROM unsloth/unsloth:latest

# Switch to root for package installation
USER root
                     
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Install NVIDIA Container Toolkit
ENV NVIDIA_CONTAINER_TOOLKIT_VERSION=1.17.8-1
RUN apt-get update && apt-get install -y \
    nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
    nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
    libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
    libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ollama
RUN wget -qO - https://ollama.com/install.sh | bash

# Install Python packages
RUN pip install --upgrade pip && \
    pip install pandas sqlalchemy ollama

# Create a default user and adjust directory ownership for proper access
RUN useradd -ms /bin/bash defaultuser && \
    chown -R defaultuser:defaultuser /home/defaultuser

USER defaultuser

# Set the working directory
WORKDIR /home/defaultuser

ENV OLLAMA_MODELS=/home/defaultuser/.ollama/models

# Start the container with an endless running task
CMD [ "/bin/sh", "-c", "tail -f /dev/null" ]
