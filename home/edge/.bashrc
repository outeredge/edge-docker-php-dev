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
[ -n "$GITPOD_ENVIRONMENT_ID" ] && source /ona.sh

# Enable bash completions for Git and Magerun
source /usr/share/bash-completion/completions/git
source /etc/profile.d/n98-magerun2.phar.bash

# Set PATH to include node and composer
export PATH="$PATH:./node_modules/.bin:./vendor/bin"

# Set RUNTIME_URL for remote sessions
[ -z "$RUNTIME_URL" -a -f "/tmp/runtime.url" ] && export RUNTIME_URL=$(cat /tmp/runtime.url)

# Load custom environment variables from .env when CUSTOM_VARS_SET is empty
if [ -z "$CUSTOM_VARS_SET" -a -f "$WEB_ROOT/.env" ]; then
    set -a; . $WEB_ROOT/.env; export CUSTOM_VARS_SET=1; set +a
fi
