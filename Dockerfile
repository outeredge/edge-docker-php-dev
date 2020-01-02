FROM outeredge/edge-docker-magento:1.9.4.3-php7 AS magento
FROM outeredge/edge-docker-php:7.2-alpine

ENV UNISON=/projects/.unison \
    UNISONLOCALHOSTNAME=dev-server \
    APPLICATION_ENV=dev

RUN sudo chmod g=u /etc/passwd && \
    sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        php7-pecl-imagick \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_security.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/

CMD ["/magento.sh"]
