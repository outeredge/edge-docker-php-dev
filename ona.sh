#!/bin/bash

export RUNTIME_URL=$(gitpod environment port open 8080 --name nginx)/
export WEB_ROOT=$(find /workspaces/ -maxdepth 1 -mindepth 1 -type d -not -name ".*" | head -n 1)
export COMPOSER_HOME=/workspaces/.composer
export YARN_CACHE_FOLDER=/workspaces/.yarn
export npm_config_cache=/workspaces/.npm
