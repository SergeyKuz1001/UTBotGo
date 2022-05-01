#!/bin/bash
source .env
make .docker_image > /dev/null || ( \
    echo "$1" | docker login ghcr.io -u sergeykuz1001 --password-stdin; \
    docker build -t $HELLO_WORLD_DOCKER_IMAGE .; \
    docker push $HELLO_WORLD_DOCKER_IMAGE; \
    make .docker_image > /dev/null \
)
