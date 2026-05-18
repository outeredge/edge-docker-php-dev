#!/bin/bash

# Configuration: map of Magento versions to their required PHP version
declare -A MAGENTO_VERSIONS=(
    ["2.4.9"]="8.4"
    ["2.4.8-p5"]="8.3"
    ["2.4.7-p10"]="8.3"
)

# Configuration: list of PHP versions to build
PHP_VERSIONS=("8.3" "8.4")

if [ -z "$MAGENTO_COMPOSER_AUTH" ]; then
    echo "No \$MAGENTO_COMPOSER_AUTH value set, exiting!"
    exit
fi;

if [ ! -z "$DOCKER_PASS" ]; then
    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
fi

build_php() {
    local php_ver=$1
    echo "Building image outeredge/edge-docker-php-dev:${php_ver}-frankenphp with Dockerfile.php${php_ver//./}-frankenphp"
    DOCKER_BUILDKIT=1 docker build --pull . -t outeredge/edge-docker-php-dev:${php_ver}-frankenphp -f Dockerfile.php${php_ver//./}-frankenphp && \
    docker push outeredge/edge-docker-php-dev:${php_ver}-frankenphp
}

build_magento() {
    local magento_ver=$1
    local php_ver=${MAGENTO_VERSIONS[$magento_ver]}
    
    echo "Building image outeredge/edge-docker-php-dev:magento-${magento_ver} with Dockerfile.magento-frankenphp (PHP ${php_ver})"
    DOCKER_BUILDKIT=1 docker build . -t outeredge/edge-docker-php-dev:magento-${magento_ver} \
        -f Dockerfile.magento-frankenphp \
        --build-arg PHP_VERSION=${php_ver} \
        --build-arg COMPOSER_AUTH=${MAGENTO_COMPOSER_AUTH} \
        --build-arg MAGENTO_VERSION=${magento_ver} && \
    docker push outeredge/edge-docker-php-dev:magento-${magento_ver}
}

if [ -z "$1" ]; then
    echo "No version specified, building all from configuration..."
    for php_ver in "${PHP_VERSIONS[@]}"; do
        build_php "$php_ver"
    done
    for magento_ver in "${!MAGENTO_VERSIONS[@]}"; do
        build_magento "$magento_ver"
    done
else
    # If a specific PHP version is provided, build that and its dependent Magento versions
    php_ver=$1
    build_php "$php_ver"
    
    for magento_ver in "${!MAGENTO_VERSIONS[@]}"; do
        if [ "${MAGENTO_VERSIONS[$magento_ver]}" == "$php_ver" ]; then
            build_magento "$magento_ver"
        fi
    done
fi

echo "Complete!"