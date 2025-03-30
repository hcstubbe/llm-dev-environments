FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

# Installieren von Systemabhängigkeiten und Python
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        gcc \
        git \
        curl \
        wget \
        gnupg \
        libssl-dev \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Python-Verknüpfung erstellen
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade von pip und Installation von Python-Paketen
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir torch==2.4.0 -f https://download.pytorch.org/whl/torch_stable.html && \
    pip install --no-cache-dir \
        git+https://github.com/huggingface/transformers.git \
        pandas \
        sqlalchemy \
        trl \
        peft \
        accelerate \
        bitsandbytes \
        ollama && \
    pip install --no-cache-dir "unsloth[cu121-torch240] @ git+https://github.com/unslothai/unsloth.git"

# Download und Installation von Ollama
RUN wget -qO - https://ollama.com/install.sh | bash

# Erstellen eines Standardbenutzers
RUN useradd -ms /bin/bash defaultuser
USER defaultuser

# Arbeitsverzeichnis festlegen
WORKDIR /home/defaultuser

# Startbefehl
CMD ["tail", "-f", "/dev/null"]