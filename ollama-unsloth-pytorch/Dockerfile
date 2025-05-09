FROM pytorch/pytorch:2.5.0-cuda12.4-cudnn9-devel
                     
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ollama
RUN wget -qO - https://ollama.com/install.sh | bash

# Disable Flash Attention for compatibility
ENV FLASH_ATTN_DISABLE=1

# Install Python packages
RUN pip install --upgrade pip && \
    pip install --upgrade --no-cache-dir "git+https://github.com/huggingface/transformers@v4.49.0-Gemma-3" && \
    pip install pandas sqlalchemy xformers==0.0.29.post3 peft trl==0.15.2 accelerate bitsandbytes ollama && \
    pip install "unsloth[cu124-ampere-torch250] @ git+https://github.com/unslothai/unsloth.git"
    
# Add llama.cpp instructions
RUN mkdir -p /home/defaultuser/ && \
    cd /home/defaultuser/ && \
    git clone https://github.com/ggerganov/llama.cpp && \
    cmake llama.cpp -B llama.cpp/build -DBUILD_SHARED_LIBS=ON -DGGML_CUDA=ON -DLLAMA_CURL=ON && \
    cmake --build llama.cpp/build --config Release -j --clean-first --target llama-quantize llama-cli llama-gguf-split && \
    cp llama.cpp/build/bin/llama-* ./llama.cpp/

# Create a default user and adjust directory ownership for proper access
RUN useradd -ms /bin/bash defaultuser && \
    chown -R defaultuser:defaultuser /home/defaultuser

USER defaultuser

# Set the working directory
WORKDIR /home/defaultuser

ENV OLLAMA_MODELS=/home/defaultuser/.ollama/models

# Start the container with an endless running task
CMD [ "/bin/sh", "-c", "tail -f /dev/null" ]
