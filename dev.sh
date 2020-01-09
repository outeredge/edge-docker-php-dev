#!/bin/bash -e

if [ ! -d "/home/edge/.composer" ] || [ -n "$(ls -A "/home/edge/.composer")" ]; then
  cp -rT /home/edge/.composer.orig /home/edge/.composer &
fi

exec /magento.sh
