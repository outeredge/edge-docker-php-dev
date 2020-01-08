FROM outeredge/edge-docker-magento:1.9.4.3-php7 AS magento
FROM outeredge/edge-docker-php:7.1-alpine

ENV PHP_DISPLAY_ERRORS=On \
    APPLICATION_ENV=dev \
    UNISON=/projects/.unison \
    UNISONLOCALHOSTNAME=dev-server

RUN sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        php7-iconv \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun/master/res/autocompletion/bash/n98-magerun.phar.bash -P /etc/profile.d && \
    mv /home/edge/.composer /home/edge/.composer.orig

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_security.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/
COPY --from=magento /uploader.patch /

COPY --chown=edge /.bashrc /home/edge/.bashrc
COPY /dev.sh /

CMD ["/dev.sh"]
