#!/bin/bash

export RUNTIME_URL=$(gp url $NGINX_PORT)/
export WEB_ROOT=$GITPOD_REPO_ROOT
export COMPOSER_HOME=/workspace/.composer
export YARN_CACHE_FOLDER=/workspace/.yarn
export npm_config_cache=/workspace/.npm
