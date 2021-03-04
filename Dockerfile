FROM outeredge/edge-docker-magento:1.9.4.4 AS magento1
FROM outeredge/edge-docker-php:5.6-alpine

ENV PHP_DISPLAY_ERRORS=On \
    APPLICATION_ENV=dev \
    MAGE_IS_DEVELOPER_MODE=true \
    ENABLE_DEV=On

RUN sudo apk add --no-cache \
        jq \
        less \
        libsass \
        mysql-client \
        php5-gd \
        coreutils && \
    # Install Magerun
    sudo wget https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun/master/res/autocompletion/bash/n98-magerun.phar.bash -P /etc/profile.d && \
    mv /home/edge/.composer /home/edge/.composer.orig && \
    # Create gitpod user and group
    sudo addgroup -g 33333 -S gitpod && \
    sudo adduser -u 33333 -D -S -s /bin/bash -h /home/gitpod -G edge gitpod && \
    sudo addgroup gitpod wheel && \
    sudo addgroup nginx gitpod && \
    sudo addgroup www-data gitpod

COPY --from=magento1 /etc/nginx/magento_security.conf /etc/nginx/
COPY --from=magento1 /templates/nginx-magento.conf.j2 /templates/nginx-magento1.conf.j2

COPY --chown=edge /.bash* /home/edge/
COPY --chown=gitpod /.bash* /home/gitpod/

COPY dev.sh gitpod.sh /

CMD ["/dev.sh"]
