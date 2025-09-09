# Source other scripts
[ ! -z "$GITPOD_ENVIRONMENT_ID" ] && source /ona.sh
[ ! -z "$GITPOD_WORKSPACE_ID" ] && source /gitpod.sh
source /etc/profile.d/bash_completion.sh
source /usr/share/bash-completion/completions/git
source /etc/profile.d/n98-magerun2.phar.bash

# Set aliases
alias magento="$WEB_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$WEB_ROOT"
alias magerun="magerun2"
alias nuke="$WEB_ROOT/bin/magento outeredge:nuke"

# Set bash prompt
export PS1='\[\033[01;32m\]\[\033[0m\033[0;32m\]\[\033[01;32m\]outer/edge\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '

# Set environment variables
export COMPOSER_MEMORY_LIMIT=-1
export PATH="$PATH:./node_modules/.bin:./vendor/bin"

[ -f "/tmp/runtime.url" ] && export RUNTIME_URL=$(cat /tmp/runtime.url)

# Load custom environment variables from .env when CUSTOM_VARS_SET is empty
if [ -z "$CUSTOM_VARS_SET" -a -f "$WEB_ROOT/.env" ]; then
    set -a; . $WEB_ROOT/.env; export CUSTOM_VARS_SET=1; set +a
fi

[ -z "$EDITOR" ] && export EDITOR="nano"

# Switch pwd to web root (on Gitpod Classic only)
[ ! -z "$GITPOD_WORKSPACE_ID" ] && cd $WEB_ROOT
