#!/bin/bash

export COMPOSER_HOME="/home/$(whoami)/.composer"

if [ ! -z "${GITPOD_ENVIRONMENT_ID}" ]; then
    # We are running in Ona
    source /ona.sh
elif [ ! -z "${GITPOD_WORKSPACE_ID}" ]; then
    # We are running in Gitpod
    source /gitpod.sh
    if [ "$ENABLE_SSH" = "On" ]; then
        echo "gitpod:$SSH_PASSWORD" | sudo chpasswd
    fi
fi

if [ "$COMPOSER_VERSION" = "1" ]; then
    if [ ! -d "/home/$(whoami)/.composer/vendor" ] || [ -n "$(ls "/home/$(whoami)/.composer/vendor")" ]; then
        cp -rfT /home/edge/.composer.orig $COMPOSER_HOME &
    fi
fi

echo "$RUNTIME_URL" > /tmp/runtime.url

exec /launch.sh