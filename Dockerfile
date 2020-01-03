FROM outeredge/edge-docker-magento:2.2.10 AS magento
FROM outeredge/edge-docker-php:7.1-alpine

ENV UNISON=/projects/.unison \
    UNISONLOCALHOSTNAME=dev-server

RUN sudo chmod g=u /etc/passwd && \
    sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        unison && \
    sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/

CMD ["/magento.sh"]
