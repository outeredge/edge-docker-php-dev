# edge-docker-php-dev

PHP development image by outer/edge - plays nicely with Ona (Gitpod).

See the base image [edge-docker-php](https://github.com/outeredge/edge-docker-php) for configuration options. The following additional configuration is available with this image:

| Environment       | Default | Description |
| -------------     | ------- | --- |
| NEWRELIC_LICENSE  | -       | New Relic license key to enable New Relic PHP agent |
| XDEBUG_ENABLE     | On      | Enables the Xdebug PHP extension |
| XDEBUG_HOST       | -       | Specify the remote host Xdebug should connect to |

When running in Ona, add the following to your `automations.yaml`:

```yml
services:
  servers:
    name: supervisord
    description: Launches PHP, Nginx and Redis
    commands:
      start: /entrypoint.sh /dev.sh
    triggeredBy:
      - postEnvironmentStart
```
