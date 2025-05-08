VERSION=$1
docker build --no-cache -t hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION -f Dockerfile . && \
docker tag hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest && \
docker push hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION && \
docker push hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest
