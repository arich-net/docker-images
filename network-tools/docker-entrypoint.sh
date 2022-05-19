#!/bin/bash

# If the env variables HTTP_PORT and HTTPS_PORT are defined, then
#   modify/Replace default listening ports 80 and 443 to whatever the user wants.
# If these variables are not defined, then the default ports 80 and 443 are used.

if [ -n "${HTTP_PORT}" ]; then
  echo "Replacing default HTTP port (80) with the value specified by the user - (HTTPS_PORT: ${HTTP_PORT})."
  sed -i "s/80/${HTTP_PORT}/g"  /etc/nginx/conf.d/default.conf
fi

if [ -n "${HTTPS_PORT}" ]; then
  echo "Replacing default HTTPS port (443) with the value specified by the user - (HTTPS_PORT: ${HTTPS_PORT})."
  sed -i "s/443/${HTTPS_PORT}/g"  /etc/nginx/conf.d/default.conf
fi


# Execute the command specified as CMD in Dockerfile:
exec "$@"