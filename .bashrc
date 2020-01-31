source /usr/share/git-core/contrib/git-prompt.sh
export PS1='\[\033[01;32m\]\[\033[0m\033[0;32m\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)$ '
export VISUAL=nano
export EDITOR="$VISUAL"
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/n98-magerun.phar.bash
[ ! -z "$MAGE_ROOT" ] && cd $MAGE_ROOT
