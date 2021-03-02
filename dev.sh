#!/bin/bash

if [[ ! -z "${CHE_WORKSPACE_ID}" ]]; then
    # We are running in Eclipse Che
    CHE_INFO=$(curl --silent --max-time 5 $CHE_API/workspace/$CHE_WORKSPACE_ID?token=$CHE_MACHINE_TOKEN)
    export RUNTIME_URL=$(echo $CHE_INFO | jq -re '.runtime.machines[]? | select(.attributes.source == "recipe").servers | first(..|.url? | select(.!=null))')
elif [[ ! -z "${GITPOD_WORKSPACE_ID}" ]]; then
    # We are running in Gitpod
    source /gitpod.sh
fi

echo "$RUNTIME_URL" > /tmp/runtime.url

exec /launch.sh