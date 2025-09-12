#!/bin/bash

# Set environment up
export RUNTIME_URL=$(gitpod environment port open 8080 --name nginx)/
export WEB_ROOT=$(find /workspaces/ -maxdepth 1 -mindepth 1 -type d -not -name ".*" | head -n 1)
export EDITOR='code --wait'

# Set common aliases
alias magento="$WEB_ROOT/bin/magento"
alias magerun2="magerun2 --root-dir=$WEB_ROOT"
alias magerun="magerun2"
alias nuke="$WEB_ROOT/bin/magento outeredge:nuke"
