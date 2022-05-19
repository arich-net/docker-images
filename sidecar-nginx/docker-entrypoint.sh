#!/bin/sh
# Check if /certs is mounted to generate automatically generated 

if [[ "$(cat /proc/mounts | egrep '/certs')" == "" ]]
then
  # Generate Random
  # That means /certs is not mounted then we create self signed certs
  CERT_SERIAL=$(< /dev/urandom tr -dc 0-9 | head -c12)
  echo "Creating self signed cert with serial $CERT_SERIAL"
  openssl req -x509 -newkey rsa:2048 \
              -nodes -days 3650 \
              -set_serial $CERT_SERIAL \
              -keyout /certs/tls.key -out /certs/tls.crt -subj "/CN=$(hostname)"
fi

# If the env variables HTTP_PORT and HTTPS_PORT are defined, then
#   modify/Replace default listening ports 80 and 443 to whatever the user wants.
# If these variables are not defined, then the default ports 80 and 443 are used.

if [[ -z "${NGINX_PORT}" ]]; then
  echo "Replacing with default HTTPS port (443)."
  sed -e "s/%NGINX_PORT%/443/g" < /etc/nginx/templates/default.conf.template > /etc/nginx/templates/default.conf.template.2
else
  echo "Replacing default HTTPS port (443) with the value specified by the user - (NGINX_PORT: ${NGINX_PORT})."
  sed -e "s/%NGINX_PORT%/${NGINX_PORT}/g" < /etc/nginx/templates/default.conf.template > /etc/nginx/templates/default.conf.template.2
fi

if [[ -z "${NGINX_FORWARD_PORT}" ]]; then
  echo "Replacing with default forward HTTP port (80)."
  sed -e "s/%NGINX_FORWARD_PORT%/80/g" < /etc/nginx/templates/default.conf.template.2 > /etc/nginx/conf.d/default.conf
else
  echo "Replacing default forward HTTP port (80) with the value specified by the user - (NGINX_FORWARD_PORT: ${NGINX_FORWARD_PORT})."
  sed -e "s/%NGINX_FORWARD_PORT%/${NGINX_FORWARD_PORT}/g" < /etc/nginx/templates/default.conf.template.2 > /etc/nginx/conf.d/default.conf
fi


# Execute the command specified as CMD in Dockerfile:
exec "$@"