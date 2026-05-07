#!/bin/bash

export COMPOSER_HOME="/home/$(whoami)/.composer"
export YARN_CACHE_FOLDER="/home/$(whoami)/.yarn"
export npm_config_cache="/home/$(whoami)/.npm"

if command -v gitpod > /dev/null 2>&1; then
    # We are running in Ona (CLI is available)
    source /ona.sh
fi

echo "$RUNTIME_URL" > /tmp/runtime.url

if [ "${XDEBUG_ENABLE:-Off}" = "On" ]; then
    if command -v frankenphp >/dev/null 2>&1; then
        INI_DIR="$(php -r 'echo PHP_INI_DIR;')/conf.d"
        [ -f "$INI_DIR/docker-php-ext-xdebug.ini.disabled" ] && mv "$INI_DIR/docker-php-ext-xdebug.ini.disabled" "$INI_DIR/docker-php-ext-xdebug.ini" 2>/dev/null || true
    else
        sudo mv /etc/php/*/fpm/conf.d/20-xdebug.ini.disabled /etc/php/*/fpm/conf.d/20-xdebug.ini 2>/dev/null || true
    fi
fi

if command -v frankenphp >/dev/null 2>&1; then
    exec /launch-frankenphp.sh
else
    exec /launch.sh
fi