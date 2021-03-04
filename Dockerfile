FROM outeredge/edge-docker-magento:2.3.5 AS magento
FROM outeredge/edge-docker-magento:1.9.4.4-php7 AS magento1
FROM outeredge/edge-docker-php:7.2-alpine

ENV PHP_DISPLAY_ERRORS=On \
    APPLICATION_ENV=dev \
    MAGE_IS_DEVELOPER_MODE=true \
    ENABLE_DEV=On \
    ENABLE_REDIS=On \
    XDEBUG_ENABLE=On

RUN sudo apk add --no-cache \
        build-base \
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
    mv /home/edge/.composer /home/edge/.composer.orig && \
    # Create gitpod user and group
    sudo addgroup -g 33333 -S gitpod && \
    sudo adduser -u 33333 -D -S -s /bin/bash -h /home/gitpod -G edge gitpod && \
    sudo addgroup gitpod wheel && \
    sudo addgroup nginx gitpod && \
    sudo addgroup www-data gitpod

COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-magento.conf.j2 /templates/
COPY --from=magento1 /etc/nginx/magento_security.conf /etc/nginx/
COPY --from=magento1 /templates/nginx-magento.conf.j2 /templates/nginx-magento1.conf.j2

COPY --chown=edge /.bash* /home/edge/
COPY --chown=gitpod /.bash* /home/gitpod/

COPY dev.sh gitpod.sh /

CMD ["/dev.sh"]
