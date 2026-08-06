# Watchtower: One Update, No Sequel 🛠️🎬

This chart runs the maintained `nickfedor/watchtower` fork exactly once, updates
eligible containers, and exits. It only considers containers labeled
`com.centurylinklabs.watchtower.enable=true`.

The original `containrrr/watchtower` repository was archived in December 2025.
Duplex uses the actively maintained compatible fork and its current
documentation at [watchtower.nickfedor.com](https://watchtower.nickfedor.com/).

## Configure and run 🧪

```sh
cp config/watchtower/example.env config/watchtower/.env
make watchtower-config
make watchtower-run
```

Review these settings before the run:

- `WATCHTOWER_LABEL_ENABLE` should remain `true`.
- `WATCHTOWER_INCLUDE_STOPPED` and `WATCHTOWER_REVIVE_STOPPED` default to
  `false`.
- `WATCHTOWER_NOTIFICATION_URL` must be replaced or notifications disabled.
- `WATCHTOWER_DOCKER_CONFIG` points to a directory containing `config.json` only
  when registry authentication is needed.

> [!WARNING]
> The Docker socket provides control of the Docker daemon and can lead to host
> control. A read-only bind flag does not make socket API operations read-only.
> Run only trusted images and inspect the exact labels before updating.

The one-shot container labels itself `false`, so it cannot attempt a surprise
self-recast halfway through the scene.
