#!/bin/bash -e

if [ ! -d /home/edge/.composer ]; then
  echo "Copying composer build cache"
  cp -rT /home/edge/.composer.orig /home/edge/.composer
fi

exec /magento.sh
