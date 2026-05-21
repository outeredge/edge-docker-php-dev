#!/bin/bash
set -e

. /workspace.sh

if [ "${XDEBUG_ENABLE:-Off}" = "On" ]; then
    XDEBUG_QUIET=1 /usr/local/bin/xdebug on
fi

exec /launch.sh "$@"