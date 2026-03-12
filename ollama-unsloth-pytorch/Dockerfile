ARG BASE_IMAGE=unsloth/unsloth:latest
FROM ${BASE_IMAGE}
RUN pip install --no-cache-dir pandas sqlalchemy ollama
WORKDIR /workspace/work

ENV OLLAMA_MODELS=/home/unsloth/.ollama/models
CMD [ "/bin/sh", "-c", "tail -f /dev/null" ]
