FROM outeredge/edge-docker-magento:2.4.2 AS magento
FROM outeredge/edge-docker-php:7.4

CMD ["/dev.sh"]

ARG DEBIAN_FRONTEND=noninteractive

ENV PHP_DISPLAY_ERRORS=On \
    ENABLE_DEV=On \
    ENABLE_REDIS=On \
    XDEBUG_ENABLE=On

COPY --from=magento /templates/magento.conf.j2 /templates/
COPY --from=magento /templates/nginx-vsf.conf.j2 /templates/
COPY --from=magento /templates/nginx-magento.conf.j2 /templates/

COPY --chown=edge . /

RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends --yes \
        imagemagick \
        jq \
        libsass1 \
        mysql-client \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-imagick \
        vim \
    # Install Magerun
    && sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun2 \
    && sudo chmod +x /usr/local/bin/magerun2 \
    && sudo wget https://raw.githubusercontent.com/netz98/n98-magerun2/master/res/autocompletion/bash/n98-magerun2.phar.bash -P /etc/profile.d \
    # Create gitpod user and group
    && sudo addgroup --gid 33333 --system gitpod \
    && sudo adduser --uid 33333 --system --shell /bin/bash --ingroup gitpod gitpod \
    && sudo addgroup gitpod edge \
    && sudo addgroup gitpod sudo \
    && sudo addgroup nginx gitpod \
    && sudo addgroup www-data gitpod \
    && sudo cp -rf /home/edge/. /home/gitpod/ \
    && sudo chown -R gitpod:gitpod /home/gitpod/ \
    # Cleanup
    && sudo rm -rf /var/lib/apt/lists/*