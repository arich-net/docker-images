#FROM nginx:1.19
FROM arichnet/alpine-nginx:1.19.9-r1

# Copy a simple index.html to eliminate text (index.html) noise which comes with default nginx image.
# (I created an issue for this purpose here: https://github.com/nginxinc/docker-nginx/issues/234)
#COPY index.html /usr/share/nginx/html/

# Copy a custom nginx.conf with log files redirected to stderr and stdout
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf.template /etc/nginx/templates/default.conf.template
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Nuild default.conf out of the template
#COPY default.conf /etc/nginx/conf.d/default.conf

RUN mkdir /certs \
    && chgrp -R 0 /certs \
    && chmod -R g+rwX /certs \
    && chgrp -R 0 /var/run \
    && chmod -R g+rwX /var/run \
    && chgrp -R 0 /etc/nginx \
    && chmod -R g+rwX /etc/nginx \
    && mkdir /etc/nginx/conf.d \
    && chgrp -R 0 /etc/nginx/conf.d \
    && chmod -R g+rwX /etc/nginx/conf.d \
    && chgrp -R 0 /var/log/nginx \
    && chmod -R g+rwX /var/log/nginx \
    && chgrp -R 0 /var/cache/nginx \
    && chmod -R g+rwX /var/cache/nginx

# Entry Point
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]




