FROM outeredge/edge-docker-magento:1.9.4.4 AS magento1
FROM outeredge/edge-docker-php:5.6-alpine

ENV PHP_DISPLAY_ERRORS=On \
    CHROME_HOST=http://chrome.default:9222 \
    APPLICATION_ENV=dev \
    MAGE_IS_DEVELOPER_MODE=true \
    UNISON=/projects/.unison \
    UNISONLOCALHOSTNAME=dev-server

RUN sudo apk add --no-cache \
        jq \
        less \
        libsass \
        mysql-client \
        php5-gd \
        coreutils \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun && \
    sudo wget https://raw.githubusercontent.com/netz98/n98-magerun/master/res/autocompletion/bash/n98-magerun.phar.bash -P /etc/profile.d && \
    mv /home/edge/.composer /home/edge/.composer.orig

WORKDIR /projects

COPY --from=magento1 /etc/nginx/magento_security.conf /etc/nginx/
COPY --from=magento1 /templates/nginx-magento.conf.j2 /templates/nginx-magento1.conf.j2

COPY --chown=edge /.bashrc /home/edge/.bashrc
COPY /dev.sh /
COPY /che.sh /etc/profile.d/

CMD ["/dev.sh"]
