# edge-docker-php-dev

PHP development image by outer/edge - plays nicely with Ona (Gitpod).

See the base image [edge-docker-php](https://github.com/outeredge/edge-docker-php) for configuration options. The following additional configuration is available with this image:

| Environment       | Default | Description |
| -------------     | ------- | --- |
| XDEBUG_ENABLE     | Off     | Enables the Xdebug PHP extension |
| XDEBUG_HOST       | -       | Specify the remote host Xdebug should connect to |

You can also quickly enable or disable Xdebug on demand using the CLI:
```bash
xdebug on
xdebug off
```

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
