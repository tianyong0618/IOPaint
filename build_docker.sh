#!/usr/bin/env bash
set -e

GIT_TAG=$1
IMAGE_DESC="Image inpainting, outpainting tool powered by SOTA AI Model" 
GIT_REPO="https://github.com/Sanster/IOPaint"

# 检查是否提供了平台参数，默认为linux/amd64
PLATFORM=${2:-linux/amd64}

echo "Building cpu docker image for platform: $PLATFORM..."

docker buildx build \
--platform $PLATFORM \
--file ./docker/CPUDockerfile \
--label org.opencontainers.image.title=iopaint \
--label org.opencontainers.image.description="$IMAGE_DESC" \
--label org.opencontainers.image.url=$GIT_REPO \
--label org.opencontainers.image.source=$GIT_REPO \
--label org.opencontainers.image.version=$GIT_TAG \
--build-arg version=$GIT_TAG \
--tag iopaint:cpu-$GIT_TAG .


# echo "Building NVIDIA GPU docker image..."
# 
# docker buildx build \
# --platform $PLATFORM \
# --file ./docker/GPUDockerfile \
# --label org.opencontainers.image.title=iopaint \
# --label org.opencontainers.image.description="$IMAGE_DESC" \
# --label org.opencontainers.image.url=$GIT_REPO \
# --label org.opencontainers.image.source=$GIT_REPO \
# --label org.opencontainers.image.version=$GIT_TAG \
# --build-arg version=$GIT_TAG \
# --tag iopaint:gpu-$GIT_TAG .

# 使用说明：
# 1. 构建amd64版本镜像（默认）：
#    ./build_docker.sh 1.6.0
# 
# 2. 构建arm64版本镜像（适用于M1/M2/M3 Mac）：
#    ./build_docker.sh 1.6.0 linux/arm64/v8
# 
# 3. 运行容器：
#    docker run -p 8080:8080 -it iopaint:cpu-1.6.0
# 
# 4. 在容器内部启动IOPaint服务：
#    iopaint start --port 8080 --host 0.0.0.0
