# Docker Project Setup 🏗️🐳

This is the full production binder for deploying Duplex with Docker Compose or
Synology DSM 7.2+ Container Manager. Read it before moving an existing checkout
to the modernized chart; several environment variable names and container names
changed so future upgrades stop leaving duplicate cast members backstage.

## Before opening night 🎬

Confirm the host has:

- Docker Engine and `docker compose`, or Synology Container Manager.
- Enough storage for application databases, caches, and rotated logs.
- A current backup of Plex application data and every Duplex config directory.
- A user and group that can write the application config paths.
- Git installed if the Kometa config will stay linked as a submodule.

> [!IMPORTANT]
> A successful `docker compose config` proves only that the chart renders. It
> does not prove an application database migration, Plex write operation, or
> automated container replacement is safe. Backups are the stunt doubles that
> keep the lead actor alive.

## Clone or refresh the repository 📦

For a new deployment:

```sh
git clone --recurse-submodules \
    https://github.com/scottgigawatt/duplex.git \
    /volume1/docker/duplex
cd /volume1/docker/duplex
```

For an existing deployment:

```sh
cd /volume1/docker/duplex
git pull --ff-only
git submodule update --init --recursive
```

Do not replace `config/kometa` with an ordinary directory. It is a separate
repository tracked through the Duplex submodule pointer.

## Migrate an older `.env` 🔄

Keep the existing private `.env` as a backup and compare it with the new example:

```sh
cp .env .env.before-duplex-modernization
diff -u .env.before-duplex-modernization example.env
```

The current chart uses complete image references and clearer host paths:

| Older variable | Current variable or action |
| -------------- | -------------------------- |
| `KOMETA_TAG` | Set `KOMETA_IMAGE` |
| `IMAGE_MAID_TAG` | Set `IMAGEMAID_IMAGE` |
| `PATTRMM_TAG` | Set `PATTRMM_IMAGE` |
| `TAUTULLI_TAG` | Set `TAUTULLI_IMAGE` |
| `NOTIFIARR_TAG` | Set `NOTIFIARR_IMAGE` |
| `WATCHTOWER_TAG` | Set `WATCHTOWER_IMAGE` |
| `HOST_VOLUME` | Set the explicit `HOST_PLEX_CONFIG` path |
| `HOST_DUPLEX_PATH` | Remove; the chart uses `HOST_DUPLEX_CONFIG` |
| Watchtower `config.json` file path | Set `WATCHTOWER_DOCKER_CONFIG` to its containing directory |

The simplest safe migration is to create a fresh file and transfer only the
deployment-specific values:

```sh
cp example.env .env.new
```

Edit `.env.new`, validate it, then replace `.env` during a maintenance window.
Do not commit either private file.

## Configure host paths and permissions 📂

Set these primary paths in `.env`:

```sh
HOST_DUPLEX_CONFIG="${HOST_DUPLEX_CONFIG:-/volume1/docker/duplex/config}"
HOST_PLEX_CONFIG="${HOST_PLEX_CONFIG:-/volume1/PlexMediaServer/AppData/Plex Media Server}"
```

`HOST_PLEX_CONFIG` must be the directory that contains Plex's `Cache`,
`Metadata`, and `Plug-in Support` directories. ImageMaid needs write access
because its purpose is to modify Plex image state.

Set `PATTRMM_PUID`, `PATTRMM_PGID`, `TAUTULLI_PUID`, and `TAUTULLI_PGID` to a
host identity that can write the corresponding config directories. On a shell
host, inspect the current identity with:

```sh
id
```

> [!WARNING]
> Do not solve permission problems with world-writable directories. Match the
> configured UID and GID to deliberate host ownership instead.

## Configure Docker networking 🌍🔧

Duplex reserves a private subnet and a smaller allocation range:

```sh
COMPOSE_NETWORK_SUBNET="${COMPOSE_NETWORK_SUBNET:-172.30.0.0/16}"
COMPOSE_NETWORK_IP_RANGE="${COMPOSE_NETWORK_IP_RANGE:-172.30.5.0/24}"
COMPOSE_NETWORK_GATEWAY="${COMPOSE_NETWORK_GATEWAY:-172.30.5.254}"
```

Before deployment, confirm the subnet does not overlap:

- the Synology LAN
- VPN routes
- other Docker networks
- remote networks reached through site-to-site routing

Inspect current Docker networks with:

```sh
docker network ls
docker network inspect NETWORK_NAME
```

The Docker Compose [IPAM reference](https://docs.docker.com/reference/compose-file/networks/#ipam)
describes the supported network fields.

## Configure application secrets 🔐

Duplex intentionally keeps live credentials outside git.

- Configure Kometa inside the private `config/kometa` checkout.
- Copy `config/imagemaid/example.env` to `config/imagemaid/.env` and replace the
  Plex token placeholder.
- Complete Notifiarr's first-run setup at port `5454`; keep the generated
  `notifiarr.conf` private.
- Copy the one-shot chart examples only when those tools are needed.
- Replace or disable the Watchtower notification URL before deployment.

Never post private Compose renders or application logs without checking for
tokens, webhook URLs, hostnames, and library details.

## Validate before deployment 🧪

Run the complete checked-in test path:

```sh
make help
make validate
pre-commit run --all-files
```

Then render the private deployment locally:

```sh
make config
```

Review service images, mounts, ports, labels, and network settings. Treat the
render as sensitive because environment values are interpolated.

## Deploy with Synology Container Manager 📦🚀

1. Open **Container Manager** in DSM.
2. Open **Project** and choose **Create**.
3. Set the project name to `duplex`.
4. Set the project path to `/volume1/docker/duplex` or the chosen clone path.
5. Select the repository's `docker-compose.yml`.
6. Review the rendered services, bind mounts, ports, and network.
7. Build and start the project.

The Synology
[Container Manager project guide](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7)
covers the DSM interface.

From a shell, the equivalent launch is:

```sh
make up
docker compose ps
```

## Firewall settings 🔥🛡️

Only expose ports needed by trusted clients:

| Default port | Service | Purpose |
| ------------ | ------- | ------- |
| `8181/tcp` | Tautulli | Web interface |
| `5454/tcp` | Notifiarr | Web interface and Plex webhooks |

If the Synology firewall is enabled, allow those ports only from trusted LAN or
reverse-proxy addresses. Do not publish Docker's API or socket over TCP.

The custom Docker subnet is internal container traffic. Add a broader firewall
rule for it only when a verified integration requires one; an “allow everything
because the tutorial said so” rule is how a cameo becomes the villain.

## Watchtower safety boundary 🛡️

Watchtower's Docker socket grants control over containers and can lead to host
control. Duplex reduces accidental scope by:

- setting `WATCHTOWER_LABEL_ENABLE=true`
- labeling each eligible Duplex service explicitly
- excluding Watchtower itself
- excluding digest-pinned PATTRMM
- defaulting stopped-container revival to `false`

The registry credential mount is now a directory:

```sh
WATCHTOWER_DOCKER_CONFIG="${WATCHTOWER_DOCKER_CONFIG:-/volume1/docker/.docker}"
```

If all images are public, the directory may be empty. If authentication is
required, place Docker's `config.json` inside it and restrict host permissions.

## One-shot maintenance charts 🧹

### Overlay Reset

Overlay Reset is destructive and has no undo. Back up Plex, retain
`DRY_RUN="True"`, and inspect the proposed operations first:

```sh
cp config/overlay-reset/example.env config/overlay-reset/.env
make overlay-reset-config
make overlay-reset-run
```

Only disable dry-run mode after reviewing the official
[Overlay Reset documentation](https://kometa.wiki/en/latest/kometa/scripts/overlay-reset/)
and the local [recovery guide](config/overlay-reset/README.md).

### One-shot Watchtower

The optional chart updates only labeled containers and exits:

```sh
cp config/watchtower/example.env config/watchtower/.env
make watchtower-config
make watchtower-run
```

## Upgrade and rollback plan ⏪

Before a service image or submodule update:

1. Back up Plex and application config.
2. Read the upstream release notes.
3. Record the current git commit and image references.
4. Run `make validate`.
5. Pull and recreate with `make pull && make up`.
6. Check `docker compose ps` and the affected service logs.

If an update fails, restore the previous git commit and application backup, then
recreate the affected service. Do not downgrade an application database unless
upstream explicitly supports it.

## Troubleshooting 🔎

### A service cannot write its config

Confirm the host directory exists and the configured UID/GID owns it. Review the
service logs before changing permissions.

### ImageMaid cannot find Plex

Confirm `HOST_PLEX_CONFIG` contains Plex's expected application-data
directories and the bind mount renders as `/plex`.

### Notifiarr creates duplicate clients

Keep `hostname: notifiarr` stable and restart the client after correcting it.

### Compose reports an overlapping subnet

Choose an unused RFC 1918 subnet and update all three `COMPOSE_NETWORK_*`
settings together.

### Watchtower updates nothing

Confirm the target service has
`com.centurylinklabs.watchtower.enable=true`, that label filtering remains
enabled, and that the configured tag has a newer registry manifest.

That should get the production through opening night with fewer explosions,
better continuity, and exactly one acceptable amount of YAML drama: none. 🎥
