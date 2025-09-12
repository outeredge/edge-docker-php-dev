#!/bin/bash

export COMPOSER_HOME="/home/$(whoami)/.composer"
export YARN_CACHE_FOLDER="/home/$(whoami)/.yarn"
export npm_config_cache="/home/$(whoami)/.npm"

if [ ! -z "${GITPOD_ENVIRONMENT_ID}" ]; then
    # We are running in Ona
    source /ona.sh
fi

echo "$RUNTIME_URL" > /tmp/runtime.url

exec /launch.sh