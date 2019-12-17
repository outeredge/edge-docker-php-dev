#!/bin/bash -e

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
     sed "s/^edge:x:1000:1000:/edge:x:$(id -u):1000:/" /etc/passwd > /tmp/passwd
     cat /tmp/passwd > /etc/passwd
     rm /tmp/passwd
  fi
fi

echo "PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" > /home/edge/.bashrc

exec "$@"
