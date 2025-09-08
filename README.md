# edge-docker-php-dev

PHP development image by outer/edge - plays nicely with Ona (Gitpod).

See the base image [edge-docker-php](https://github.com/outeredge/edge-docker-php) for configuration options.

When running in Gitpod, add the following task:

```yml
  - command: /entrypoint.sh /dev.sh
    openMode: tab-before
    name: "Services"
```
