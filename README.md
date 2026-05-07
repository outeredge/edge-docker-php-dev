# edge-docker-php-dev

PHP development image by outer/edge - plays nicely with Ona (Gitpod).

See the base image [edge-docker-php](https://github.com/outeredge/edge-docker-php) for configuration options. The following additional configuration is available with this image:

| Environment       | Default | Description |
| -------------     | ------- | --- |
| XDEBUG_ENABLE     | Off     | Enables the Xdebug PHP extension |

You can also quickly enable or disable Xdebug on demand using the CLI:
```bash
xdebug on
xdebug off
```

## Image variants

| Tag                | Base                                       | Web server  | Process model            |
| ------------------ | ------------------------------------------ | ----------- | ------------------------ |
| `8.3` / `8.4`      | `outeredge/edge-docker-php:8.x-node`       | nginx       | supervisord (multi-proc) |
| `8.3-frankenphp` / `8.4-frankenphp` | `outeredge/edge-docker-php:8.x-frankenphp` | FrankenPHP/Caddy | single process (PID 1)   |

The `-frankenphp` variants ship Node + bun, so they are a drop-in replacement for the existing `:8.x` images for projects that don't depend on supervisord-managed sidecars (e.g. cron, redis sidecar, multiple processes managed by supervisord). `xdebug on` / `xdebug off` work the same way at the user-facing level on both tracks - the script detects which track it's running on and reloads PHP appropriately (FrankenPHP uses `frankenphp reload --force`, the nginx track uses `supervisorctl restart php-fpm`).

The FrankenPHP variants run as the unprivileged `edge` user with no `sudo`, no nginx, no php-fpm, and no supervisord. Caddy listens on `${PORT}` (default `8080`).

## Ona

When running in Ona, add the following to your `automations.yaml`.

For the **nginx** variants (`:8.3`, `:8.4`):

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

For the **FrankenPHP** variants (`:8.3-frankenphp`, `:8.4-frankenphp`):

```yml
services:
  servers:
    name: frankenphp
    description: Launches FrankenPHP
    commands:
      start: /dev.sh
    triggeredBy:
      - postEnvironmentStart
```
