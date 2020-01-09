FROM outeredge/edge-docker-magento:2.2.10 AS magento
FROM outeredge/edge-docker-php:7.1-alpine

ENV PHP_DISPLAY_ERRORS=On \
    UNISON=/projects/.unison \
    UNISONLOCALHOSTNAME=dev-server

RUN sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        php7-iconv \
        coreutils \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun2 && \
    sudo chmod +x /usr/local/bin/magerun2 && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun2/master/res/autocompletion/bash/n98-magerun2.phar.bash -P /etc/profile.d && \
    mv /home/edge/.composer /home/edge/.composer.orig

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/

COPY --chown=edge /.bashrc /home/edge/.bashrc
COPY /dev.sh /

CMD ["/dev.sh"]
