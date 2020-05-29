source /etc/profile.d/bash_completion.sh
source /etc/profile.d/n98-magerun2.phar.bash
export PS1='\[\033[01;32m\]\[\033[0m\033[0;32m\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
export VISUAL=nano
export EDITOR="$VISUAL"
export RUNTIME_URL=$(cat /tmp/runtime.url)
export MAGENTO_BACKEND_URL="$RUNTIME_URL"
alias magento="$WEB_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$WEB_ROOT"
[ ! -z "$WEB_ROOT" ] && cd $WEB_ROOT
