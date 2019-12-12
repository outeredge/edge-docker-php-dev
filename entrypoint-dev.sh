#!/bin/bash -e

CURRENT_UID="$(id -u)"
CURRENT_GID="$(id -g)"

if [ ${CURRENT_GID} -ne 1000 ]; then
  if ! whoami &> /dev/null; then
    echo "edge:x:${CURRENT_UID}:0:edge:/home/edge:/bin/bash" >> /etc/passwd
  fi
fi

echo "PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" > /home/edge/.bashrc

exec "$@"
