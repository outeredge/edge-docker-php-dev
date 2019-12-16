FROM outeredge/edge-docker-magento:2.3.3 AS magento

FROM outeredge/edge-docker-php:7.2-alpine

RUN sudo chgrp -R 0 /home && \
    sudo chmod -R g=u /etc/passwd /home && \
    sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        php7-pecl-imagick && \
    sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun && \
    sudo chmod +x /usr/local/bin/magerun

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/

COPY entrypoint-dev.sh /
ENTRYPOINT ["/entrypoint-dev.sh"]

CMD ["/magento.sh"]
