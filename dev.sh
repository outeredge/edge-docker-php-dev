#!/bin/bash -e

if [ ! -d "/home/edge/.composer/vendor" ] || [ -n "$(ls "/home/edge/.composer/vendor")" ]; then
  cp -rT /home/edge/.composer.orig /home/edge/.composer &
fi

exec /launch.sh
