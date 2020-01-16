export PS1='\[\033[01;32m\]\u@dev\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export VISUAL=nano
export EDITOR="$VISUAL"
source /etc/profile.d/bash_completion.sh
source /etc/profile.d/n98-magerun2.phar.bash
alias magento="$MAGE_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$MAGE_ROOT"
[ ! -z "$MAGE_ROOT" ] && cd $MAGE_ROOT
