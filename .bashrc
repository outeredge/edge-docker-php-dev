source /etc/profile.d/che.sh
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/n98-magerun.phar.bash
export PS1='\[\033[01;32m\]\[\033[0m\033[0;32m\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
export VISUAL=nano
export EDITOR="$VISUAL"
[ ! -z "$WEB_ROOT" ] && cd $WEB_ROOT
