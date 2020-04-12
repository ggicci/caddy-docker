# caddy-docker

Build latest caddy web server docker image from source.

**NOTE**: This Dockerfile build caddy by using [xcaddy](https://github.com/caddyserver/xcaddy). It's based on caddy v2 for now.

## Usage

Run `docker build` command as below:

```sh
docker build -t ggicci/caddy --build-arg COMMIT="68cebb28" .
```

## References

- [caddy](https://github.com/caddyserver/caddy)
- [xcaddy](https://github.com/caddyserver/xcaddy)
- [caddy-docker](https://github.com/caddyserver/caddy-docker)
