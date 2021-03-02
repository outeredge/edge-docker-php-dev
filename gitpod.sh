#!/bin/bash

export NGINX_PORT=8080
export RUNTIME_URL=$(gp url $NGINX_PORT)
export WEB_ROOT=$GITPOD_REPO_ROOT