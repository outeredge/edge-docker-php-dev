# Source other scripts
[ ! -z "$GITPOD_WORKSPACE_ID" ] && source /gitpod.sh
source /etc/profile.d/bash_completion.sh
source /usr/share/bash-completion/completions/git
source /etc/profile.d/n98-magerun2.phar.bash

# Set aliases
alias magento="$WEB_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$WEB_ROOT"
alias magerun="magerun2"

# Set bash prompt
export PS1='\[\033[01;32m\]\[\033[0m\033[0;32m\]\[\033[01;32m\]outer/edge\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '

# Set environment variables
export COMPOSER_MEMORY_LIMIT=-1
export PATH="$PATH:./node_modules/.bin:./vendor/bin"

[ -f "/tmp/runtime.url" ] && export RUNTIME_URL=$(cat /tmp/runtime.url)

# Load custom environment variables from .env
if [[ -f "$WEB_ROOT/.env" ]]; then
    set -a; . $WEB_ROOT/.env; set +a
fi

[ -z "$EDITOR" ] && export EDITOR="nano"
[ -z "$VISUAL" ] && export VISUAL="$EDITOR"
[ -z "$GIT_EDITOR" ] && export GIT_EDITOR="$EDITOR"

# Switch pwd to web root
[ ! -z "$WEB_ROOT" ] && cd $WEB_ROOT
