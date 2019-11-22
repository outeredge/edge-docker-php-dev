FROM outeredge/edge-docker-magento:2.3.3 AS magento

FROM outeredge/edge-docker-php:7.2-alpine

RUN sudo apk add --no-cache \
        mysql-client \
        libsass \
        php7-gd \
        php7-pecl-imagick

WORKDIR /projects

COPY --from=magento /magento.sh /
COPY --from=magento /etc/nginx/magento_default.conf /etc/nginx/
COPY --from=magento /templates/nginx-default.conf.j2 /templates/

CMD ["/magento.sh"]
