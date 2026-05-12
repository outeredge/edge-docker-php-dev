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
    XDEBUG_QUIET=1 /usr/local/bin/xdebug on
fi

# Launch supervisord unless a custom startup command is given
if [ $# -eq 0 ]; then
    set -- /usr/bin/supervisord
fi

exec /launch.sh "$@"
