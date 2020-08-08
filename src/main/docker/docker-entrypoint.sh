#!/bin/bash

if [ -f /docker-entrypoint-app.sh ]; then
    . /docker-entrypoint-app.sh
    [[ $? != 0 ]] && {
        echo "ERROR: docker-entrypoint-app failed; exiting..."
        exit 1
    }
fi

echo "Starting Supervisor"
exec /usr/bin/supervisord
