#!/bin/sh

. /lib.subr

set -e

if [ ! -d "${DATA_DIRECTORY}" ]; then
    mkdir -p -- "${DATA_DIRECTORY}"
fi

if [ -n "${DISABLE_AUTHENTICATION}" ]; then
    OPTIONS="--no-auth ${OPTIONS}"
else
    if [ ! -f "${PASSWORD_FILE}" ]; then
        ( umask 027 && touch "${PASSWORD_FILE}" )
    fi

    if [ ! -s "${PASSWORD_FILE}" ]; then
        warn
        warn "No user exists, please 'appjail oci exec \$JAIL create_user'"
        warn
    fi
fi

create_user

change_owner "${DATA_DIRECTORY}"

exec su-exec noroot rest-server --path "${DATA_DIRECTORY}" --htpasswd-file "${PASSWORD_FILE}" ${OPTIONS}
