VERSON=$1
docker build --no-cache -t hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION -f Dockerfile .