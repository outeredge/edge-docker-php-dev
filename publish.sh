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

echo "Building image outeredge/edge-docker-php-dev:$1-frankenphp with Dockerfile.php${1//./}-frankenphp"
DOCKER_BUILDKIT=1 docker build --pull . -t outeredge/edge-docker-php-dev:$1-frankenphp -f Dockerfile.php${1//./}-frankenphp && \
docker push outeredge/edge-docker-php-dev:$1-frankenphp && \
echo "Complete!"
