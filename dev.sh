#!/bin/bash

export COMPOSER_HOME="/home/$(whoami)/.composer"
export YARN_CACHE_FOLDER="/home/$(whoami)/.yarn"
export npm_config_cache="/home/$(whoami)/.npm"

if command -v gitpod > /dev/null 2>&1; then
    # We are running in Gitpod (CLI is available)
    source /ona.sh
fi

echo "$RUNTIME_URL" > /tmp/runtime.url

exec /launch.sh