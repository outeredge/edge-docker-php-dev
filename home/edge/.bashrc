# Inspired by https://github.com/devcontainers/features/blob/main/src/common-utils
# the default .bashrc for mcr.microsoft.com/devcontainers/base:ubuntu-24.04, simplified with tweaks for Ona

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# enable color support of ls and also add handy aliases
eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# bash theme - partly inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme
__bash_prompt() {
    local lastcmdstatus='`export XIT=$? \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]  " || echo -n "  "`'
    local gitbranch='`\
        export BRANCH="$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)"; \
        if [ "${BRANCH:-}" != "" ]; then \
            echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH:-}" \
            && if git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                echo -n " \[\033[1;33m\]✗"; \
            fi \
            && echo -n "\[\033[0;36m\])"; \
        fi`'
    local lightblue='\[\033[1;34m\]'
    local removecolor='\[\033[0m\]'
    local cleandir='`echo -n "${PWD/\/workspaces\//}"`'

    PS1="${lastcmdstatus}${lightblue}${cleandir}${gitbranch}${removecolor}\$ "
    unset -f __bash_prompt
}
__bash_prompt

# Ona environment setup
if command -v ona > /dev/null 2>&1 && [ -r /ona.sh ]; then
    . /ona.sh
fi

# Enable bash completions for Git and Magerun
source /usr/share/bash-completion/completions/git
source /etc/profile.d/n98-magerun2.phar.bash

# Set PATH to include node and composer
export PATH="$PATH:./node_modules/.bin:./vendor/bin:./bin"

# Load custom environment variables
. /etc/profile.d/edge-env.sh

# Set common aliases
alias magento="$WEB_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$WEB_ROOT"
alias magerun="magerun2"
alias nuke="$WEB_ROOT/bin/magento outeredge:nuke"
alias mysql="mysql --skip-ssl"
alias code="code-server"
