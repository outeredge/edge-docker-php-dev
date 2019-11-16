FROM outeredge/edge-docker-magento:2.3.3

WORKDIR /projects

RUN sudo apk add --no-cache \
         mysql-client