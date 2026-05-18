#!/bin/bash
set -e

if command -v ona > /dev/null 2>&1 && [ -r /ona.sh ]; then
    . /ona.sh
fi

if [ "${XDEBUG_ENABLE:-Off}" = "On" ]; then
    XDEBUG_QUIET=1 /usr/local/bin/xdebug on
fi

# Launch supervisord unless a custom startup command is given
if [ $# -eq 0 ]; then
    set -- /usr/bin/supervisord
fi

exec "$@"
