# Image
Build and push:
```
docker build --no-cache -t [docker image repo]/ollama_unsloth:v1 -f Dockerfile . && \
docker push [docker image repo]/ollama_unsloth:v1
```

Notes:
- The image extends the official `unsloth/unsloth` container and adds Ollama plus a small set of utility packages.
- Install NVIDIA Container Toolkit on the host, not inside this image.
- Override the Unsloth base image explicitly if you want to pin it during build, for example with `--build-arg BASE_IMAGE=unsloth/unsloth:latest`.
