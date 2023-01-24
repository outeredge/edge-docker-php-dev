#!/bin/bash

if [ -z "$1" ]; then
    echo "No version specified, exiting!"
    exit
fi;

r=""
if [ ! -z "$2" ]; then
    r="-$2"
fi;

if [ ! -z "$DOCKER_PASS" ]; then
    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
fi;

if [ ! -z "$r" ]; then
    echo "Building image outeredge/edge-docker-php-dev:$1$r with Dockerfile.php${1//./}"
    DOCKER_BUILDKIT=1 docker build --pull . -t outeredge/edge-docker-php-dev:$1$r -f Dockerfile.php${1//./} && \
    docker push outeredge/edge-docker-php-dev:$1$r && \
    echo "Complete!"
fi;

echo "Building image outeredge/edge-docker-php-dev:$1 with Dockerfile.php${1//./}"
DOCKER_BUILDKIT=1 docker build --pull . -t outeredge/edge-docker-php-dev:$1 -f Dockerfile.php${1//./} && \
docker push outeredge/edge-docker-php-dev:$1 && \
echo "Complete!"
