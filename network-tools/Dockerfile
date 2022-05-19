# Docker to build a flask application
FROM alpine:3.13.4

LABEL maintainer="Ariel Vasquez (arich.net@gmail.com)"

# Expose non-root ports for Openshift
EXPOSE 8443

# Install some tools in the container and generate self-signed SSL certificates.
# Packages are listed in alphabetical order, for ease of readability and ease of maintenance.
RUN     apk update \
    &&  apk add bash bind-tools busybox-extras curl ethtool git \
                iperf3 iproute2 iputils jq lftp mtr mysql-client \
                netcat-openbsd net-tools nmap openssh-client openssl \
                perl-net-telnet postgresql-client procps rsync socat \
                openldap-clients tcpdump tshark wget vim python3 \
                py3-pip supervisor gcc python3-dev musl-dev \
    &&  mkdir /certs \
    &&  mkdir /app \
    &&  mkdir /app/logs \
    &&  chmod 700 /certs \
    &&  openssl req \
        -x509 -newkey rsa:2048 -nodes -days 3650 \
        -keyout /certs/server.key -out /certs/server.crt -subj '/CN=localhost'

COPY requirements.txt /app
COPY webapp /app/
COPY supervisord.conf /etc/supervisord.conf

# Install PIP dependencies 
RUN python3 -m pip install -r /app/requirements.txt

# Make it compatible with OpenShift
RUN     chgrp -R 0 /certs \
     && chmod -R g+rwX /certs \
     && chgrp -R 0 /etc/nginx \
     && chmod -R g+rwX /etc/nginx \
     && chgrp -R 0 /var/log/nginx \
     && chmod -R g+rwX /var/log/nginx \
     && chgrp -R 0 /app \
     && chmod -R g+rwX /app

# Initiate the service
CMD [ "/usr/bin/supervisord" ]
