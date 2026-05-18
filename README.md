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
| `8.3-frankenphp` / `8.4-frankenphp` | `outeredge/edge-docker-php:8.x-frankenphp-super` | FrankenPHP/Caddy | supervisord (multi-proc, runs as `edge`) |

The `-frankenphp` variants ship Node + bun. They include `valkey` and `cloud-sql-proxy` managed by a non-root supervisord. These variants run as the unprivileged `edge` user with no `sudo`, no nginx, and no php-fpm. Caddy listens on `${PORT}` (default `8080`).

**Note:** `ENABLE_VALKEY`, `ENABLE_SQL_PROXY`, `ENABLE_SSH`, and `ENABLE_CRON` are currently unsupported toggle switches. `valkey` and `cloud-sql-proxy` are always on.

## Invocation modes

| Invocation | What happens |
|------------|--------------|
| `docker run <image>` | ENTRYPOINT `/launch.sh` runs CMD `/dev.sh` → dev.sh setup (ona/xdebug) → defaults to supervisord (multi-proc, all sidecars). |
| `docker run <image> /dev.sh frankenphp run --config /etc/caddy/Caddyfile` | launch.sh execs `/dev.sh frankenphp …` → dev.sh setup → execs frankenphp directly (single-proc). |
| `docker run <image> /dev.sh bash` | launch.sh execs `/dev.sh bash` → dev.sh setup (ona first-boot, xdebug toggle) → interactive shell. |
| `docker run <image> bash` | launch.sh execs `bash` directly — dev.sh is bypassed (CMD overridden), identical to upstream behaviour. |

## Ona

When running in Ona, add the following to your `automations.yaml`.

```yml
services:
  servers:
    name: supervisord
    description: Launches FrankenPHP, Valkey and SQL Proxy
    commands:
      start: /dev.sh
      stop: supervisorctl shutdown
    triggeredBy:
      - postEnvironmentStart
```
