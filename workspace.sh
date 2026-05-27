#!/bin/bash

# Environment variables setup for remote workspaces (memoized to avoid repeated CLI calls)
WORKSPACE_ENV_CACHE=/tmp/workspace-env.cache
if [ -r "$WORKSPACE_ENV_CACHE" ]; then
    . "$WORKSPACE_ENV_CACHE"
else
    CACHE_READY=false

    if command -v meldit > /dev/null 2>&1; then
        if RAW_ME=$(meldit me) && RAW_PREVIEW=$(meldit port 8080 --public --raw); then
            WEB_ROOT=$(echo "$RAW_ME" | jq -r '.workspacePath')
            RUNTIME_URL="$RAW_PREVIEW/"
            CACHE_READY=true
        fi
    elif command -v ona > /dev/null 2>&1; then
        if RAW_PORT=$(ona environment port open 8080 --name web); then
            : "${RUNTIME_URL:=$RAW_PORT/}"
            WEB_ROOT=$(find /workspaces/ -maxdepth 1 -mindepth 1 -type d -not -name ".*" | head -n 1)
            CACHE_READY=true
        fi
    fi

    # Only write the cache if the commands succeeded AND a WEB_ROOT was found
    if [ "$CACHE_READY" = true ] && [ -n "$WEB_ROOT" ]; then
        {
            printf 'export RUNTIME_URL=%q\n' "$RUNTIME_URL"
            printf 'export WEB_ROOT=%q\n'    "$WEB_ROOT"
            printf "export EDITOR='code --wait'\n"
        } > "$WORKSPACE_ENV_CACHE"
        . "$WORKSPACE_ENV_CACHE"
    fi
fi
