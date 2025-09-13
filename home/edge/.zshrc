export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode disabled
zstyle ':omz:*' aliases no
HIST_STAMPS="dd/mm/yyyy"
plugins=(git)
source $ZSH/oh-my-zsh.sh

PROMPT="  %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

[ -n "$GITPOD_ENVIRONMENT_ID" ] && source /ona.sh

# Set PATH to include node and composer
export PATH="$PATH:./node_modules/.bin:./vendor/bin"

# Load custom environment variables from .env when CUSTOM_VARS_SET is empty
if [ -z "$CUSTOM_VARS_SET" -a -f "$WEB_ROOT/.env" ]; then
    set -a; . $WEB_ROOT/.env; export CUSTOM_VARS_SET=1; set +a
fi
