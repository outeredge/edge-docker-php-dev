# edge-docker-php-dev

PHP development image by outer/edge - plays nicely with Ona.

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
| `8.3-frankenphp` / `8.4-frankenphp` | `outeredge/edge-docker-php:8.x-frankenphp` | FrankenPHP/Caddy | supervisord (multi-proc, runs as `edge`) |

The `-frankenphp` variants ship Node + bun, so they are a drop-in replacement for the existing `:8.x` images. They also include `redis` and `cloud-sql-proxy` managed by a non-root supervisord. These variants run as the unprivileged `edge` user with no `sudo`, no nginx, and no php-fpm. Caddy listens on `${PORT}` (default `8080`).

**Note for FrankenPHP variants:** `ENABLE_REDIS`, `ENABLE_SQL_PROXY`, `ENABLE_SSH`, and `ENABLE_CRON` are unsupported on the FrankenPHP track. `redis` and `cloud-sql-proxy` are always on. Users needing toggles or sshd/cron should use the non-frankenphp dev variants. Supercronic may be added in the future for non-root cron if demand arises.

## Invocation modes (FrankenPHP track)

| Invocation | What happens |
|------------|--------------|
| `docker run <image>` | CMD `/dev.sh` runs with no args → dev.sh setup → defaults to supervisord (multi-proc, all sidecars). |
| `docker run <image> /dev.sh frankenphp run --config /etc/caddy/Caddyfile` | dev.sh setup → forwards args → launch.sh `exec`s frankenphp directly (single-proc). |
| `docker run <image> /dev.sh bash` | dev.sh setup (ona first-boot, xdebug toggle) → interactive shell via launch.sh. |
| `docker run <image> bash` | Bypasses dev.sh entirely (CMD overridden) — identical to upstream behavior. |

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
      stop: sudo supervisorctl shutdown
    triggeredBy:
      - postEnvironmentStart
```

For the **FrankenPHP** variants (`:8.3-frankenphp`, `:8.4-frankenphp`):

```yml
services:
  servers:
    name: supervisord
    description: Launches FrankenPHP, Redis and SQL Proxy
    commands:
      start: /dev.sh
      stop: supervisorctl shutdown
    triggeredBy:
      - postEnvironmentStart
```
