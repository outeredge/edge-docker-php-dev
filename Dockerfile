FROM outeredge/edge-docker-magento:2.4.1 AS magento
FROM outeredge/edge-docker-php:7.3-alpine

ENV PHP_DISPLAY_ERRORS=On \
    ENABLE_REDIS=On \
    XDEBUG_ENABLE=On

RUN sudo apk add --no-cache \
        build-base \
        jq \
        less \
        libsass \
        mysql-client \        
        php7-gd \
        php7-pecl-imagick \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun2 && \
    sudo chmod +x /usr/local/bin/magerun2 && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun2/master/res/autocompletion/bash/n98-magerun2.phar.bash -P /etc/profile.d && \
    mv /home/edge/.composer /home/edge/.composer.orig

WORKDIR /projects

COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-magento.conf.j2 /templates/

COPY --chown=edge /.bash* /home/edge/
COPY /dev.sh /

CMD ["/dev.sh"]
