FROM outeredge/edge-docker-magento:2.4.2 AS magento
FROM outeredge/edge-docker-php:7.4-alpine

ENV PHP_DISPLAY_ERRORS=On \
    ENABLE_REDIS=On \
    XDEBUG_ENABLE=On

RUN sudo apk add --no-cache \
        build-base \
        imagemagick \
        jq \
        less \
        libsass \
        mysql-client \
        php7-gd \
        php7-pecl-imagick && \
    # Install Magerun
    sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun2 && \
    sudo chmod +x /usr/local/bin/magerun2 && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun2/master/res/autocompletion/bash/n98-magerun2.phar.bash -P /etc/profile.d && \
    # Create gitpod user and group
    sudo addgroup -g 33333 -S gitpod && \
    sudo adduser -u 33333 -D -S -s /bin/bash -h /home/gitpod -G edge gitpod && \
    sudo addgroup gitpod wheel && \
    sudo addgroup nginx gitpod && \
    sudo addgroup www-data gitpod

COPY --from=magento /templates/magento.conf.j2 /templates/
COPY --from=magento /templates/nginx-vsf.conf.j2 /templates/
COPY --from=magento /templates/nginx-magento.conf.j2 /templates/

COPY --chown=edge /.bash* /home/edge/
COPY --chown=gitpod /.bash* /home/gitpod/

COPY dev.sh gitpod.sh /

CMD ["/dev.sh"]
