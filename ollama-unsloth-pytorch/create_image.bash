VERSION=$1
OWNER=$2
OPTIONS=$3
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version> [options]"
  exit 1
fi
docker build $OPTIONS -t hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION -f Dockerfile . && \
docker tag $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION hstubbe/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest && \
docker push $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-$VERSION && \
docker push $OWNER/ollama_unsloth:pytorch2.5.0-cuda12.4-cudnn9-devel-latest
