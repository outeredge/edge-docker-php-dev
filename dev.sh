#!/bin/bash
set -e

if command -v ona > /dev/null 2>&1 && [ -r /ona.sh ]; then
    . /ona.sh
fi

if [ "${XDEBUG_ENABLE:-Off}" = "On" ]; then
    XDEBUG_QUIET=1 /usr/local/bin/xdebug on
fi

exec /launch.sh "$@"