#!/bin/bash

# Environment variables setup for Ona (memoized to avoid repeated CLI calls)
ONA_ENV_CACHE=/tmp/ona-env.cache
if [ -r "$ONA_ENV_CACHE" ]; then
    . "$ONA_ENV_CACHE"
else
    # Calculate once and memoize
    : "${RUNTIME_URL:=$(ona environment port open 8080 --name web)/}"
    WEB_ROOT=$(find /workspaces/ -maxdepth 1 -mindepth 1 -type d -not -name ".*" | head -n 1)
    {
        printf 'export RUNTIME_URL=%q\n' "$RUNTIME_URL"
        printf 'export WEB_ROOT=%q\n'    "$WEB_ROOT"
        printf "export EDITOR='code --wait'\n"
    } > "$ONA_ENV_CACHE"
    . "$ONA_ENV_CACHE"
fi
