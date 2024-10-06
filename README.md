# PHP Base image

PHP 8 + Apache + Xdebug + Composer

# Docker compose example

```yaml
services:
  app:
    image: felipegangrel/php
    volumes:
      - .:/var/www/html
    ports:
      - 80:80
    environment:
      PHP_OPCACHE_VALIDATE_TIMESTAMPS: 1 # 0 for production (enables opcache)
```

# Debugging on VSCode

I recommend using the PHP Debug extension. Here is a sample configuration for the launch.json file:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug Docker",
            "type": "php",
            "request": "launch",
            "log": true,
            "hostname": "localhost",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "${workspaceFolder}"
            },
        }
    ]
}
```

# Environment variables

- PHP_OPCACHE_VALIDATE_TIMESTAMPS: 1 for development, 0 for production (default: 0)
- XDEBUG_MODE: (default: debug)
- XDEBUG_CLIENT_HOST: Host where the IDE is running (default: host.docker.internal)
- XDEBUG_CLIENT_PORT: Port where the IDE is listening (default: 9003)
- XDEBUG_IDEKEY: IDE key (default: VSCODE)
- XDEBUG_START_WITH_REQUEST: (default: yes)

For more information, see the [Xdebug documentation](https://xdebug.org/docs/all_settings).
