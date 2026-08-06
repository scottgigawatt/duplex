<hr />

<p align="center">
  <em>🍿 Smash that ⭐️ like the streaming service just asked, “Are you still watching?”</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Lights%20On-Docker-blue?logo=docker" alt="Lights On" />
  <img src="https://img.shields.io/github/license/scottgigawatt/duplex?label=Director's%20Cut%20License&color=blue" alt="Director's Cut License" />
  <img src="https://img.shields.io/github/last-commit/scottgigawatt/duplex?label=Last%20Episode&logo=git" alt="Last Episode" />
  <img src="https://img.shields.io/github/repo-size/scottgigawatt/duplex?label=Media%20Vault" alt="Media Vault" />
  <img src="https://img.shields.io/badge/Binge--Ready-Synology%20%7C%20Docker-blue" alt="Binge-Ready" />
</p>

<p align="center">─── ⛧ ───</p>

<p align="center">
  <em>⚡ Got bugs or questionable plot decisions? Enter <strong>🔥HADES🔥</strong>.</em>
</p>

<p align="center">
  <a href="https://discord.gg/BpEGzWwGYf">
    <img src="https://img.shields.io/discord/1403601106315116626?label=%F0%9F%94%A5HADES%F0%9F%94%A5&logo=discord&logoColor=white&color=5865F2" alt="🔥HADES🔥 Discord" />
  </a>
</p>

<hr />

# Duplex 📺🚀

Duplex is the backstage crew for a Plex production that has somehow survived
multiple seasons, three recasts, and one database nobody remembers approving.
It runs metadata, artwork maintenance, monitoring, notifications, and controlled
container updates as one Docker Compose project, with Synology Container Manager
as the premiere venue.

Duplex does **not** install Plex Media Server. It connects the supporting cast to
an existing Plex installation and its application-data directory.

> [!NOTE]
> ☠️ There is a pirate crossover hidden in this season. Follow the suspiciously
> damp map to [Plundarr](config/plundarr/README.md) if ye dare.

## Tonight's cast 🎭

The default image versions below were verified against each project's official
release or deployment documentation on August 5, 2026.

| Service            | Default image                                            | Role                                           | Official source                                                 |
| ------------------ | -------------------------------------------------------- | ---------------------------------------------- | --------------------------------------------------------------- |
| **Kometa** ✨      | `kometateam/kometa:v2.4.6`                               | Metadata, collections, playlists, and overlays | [Wiki](https://kometa.wiki/en/latest/)                          |
| **ImageMaid** 🧼   | `kometateam/imagemaid:v1.2.0`                            | Plex image-cache maintenance                   | [Wiki](https://kometa.wiki/en/latest/kometa/scripts/imagemaid/) |
| **PATTRMM** 📅     | `ghcr.io/insertdisc/pattrmm:latest` at a reviewed digest | Returning Soon and In-History metadata         | [Repository](https://github.com/InsertDisc/pattrmm)             |
| **Tautulli** 📊    | `tautulli/tautulli:v2.17.2`                              | Plex activity monitoring                       | [Docs](https://docs.tautulli.com/getting-started/installation)  |
| **Notifiarr** 🔔   | `golift/notifiarr:0.9.5`                                 | Notifications and service checks               | [Wiki](https://notifiarr.wiki/pages/client/install/)            |
| **Watchtower** 🛠️  | `nickfedor/watchtower:1.20.3`                            | Label-scoped container updates                 | [Docs](https://watchtower.nickfedor.com/)                       |

Kometa Overlay Reset has its own one-shot chart under
[`config/overlay-reset`](config/overlay-reset/README.md). It is deliberately not
part of the everyday cast because its entire job description is “remove things
with confidence.”

## What changed in this director's cut? 🎬

- Release-capable services use current versioned image tags instead of every
  container improvising on `latest`.
- PATTRMM's only stable channel is pinned to a reviewed multi-architecture
  digest.
- Watchtower now uses the maintained community fork. The original
  `containrrr/watchtower` project was archived in December 2025.
- Watchtower updates only containers with an explicit enable label. It no longer
  wanders through the entire Docker host like an intern with a master key.
- Compose files omit the obsolete top-level `version` field and use stable
  container names.
- Renovate, CodeQL, OpenSSF Scorecard, secret scanning, Markdown linting,
  ShellCheck, actionlint, and strict YAML validation now cover the repository.
- Checked-in examples drive validation; private `.env` files stay off camera.

## Requirements 🧰

- Docker Engine with Docker Compose v2, or Synology DSM 7.2+ with Container
  Manager.
- An existing Plex Media Server.
- A Plex token for Kometa, ImageMaid, PATTRMM, Tautulli, or Overlay Reset where
  each upstream tool requires one.
- Read/write access to the Duplex config directory.
- Read/write access to Plex application data for ImageMaid.
- Git submodule support for the Kometa configuration.

## Quick premiere 🚀

Clone Duplex with its Kometa configuration submodule:

```sh
git clone --recurse-submodules \
    https://github.com/scottgigawatt/duplex.git \
    /volume1/docker/duplex
cd /volume1/docker/duplex
```

Create private environment files from the checked-in examples:

```sh
cp example.env .env
cp config/imagemaid/example.env config/imagemaid/.env
```

Review at least these settings before opening night:

- `HOST_DUPLEX_CONFIG`
- `HOST_PLEX_CONFIG`
- `PATTRMM_PUID` and `PATTRMM_PGID`
- `TAUTULLI_PUID` and `TAUTULLI_PGID`
- `COMPOSE_NETWORK_*`
- `WATCHTOWER_NOTIFICATION_URL`, or disable notifications
- Plex URLs and tokens in each application's private configuration

Then rehearse and launch:

```sh
make help
make validate
make config
make up
```

`make validate` uses only safe checked-in examples. `make config` renders the
private deployment and may display interpolated values, so do not paste its
output into issues without redacting it.

> [!IMPORTANT]
> Read the full [Docker Project Setup](SETUP.md) before deploying on Synology.
> It covers networking, permissions, Container Manager, upgrades, and the image
> variable migration from older Duplex checkouts. Skipping it is how the plucky
> side character becomes a six-hour troubleshooting subplot.

## First-run service notes 📋

### Kometa and ImageMaid

The Kometa configuration is a git submodule at `config/kometa`. ImageMaid reads
its application settings from `config/imagemaid/.env` and needs the Plex
application-data directory mounted at `/plex`.

### PATTRMM

PATTRMM writes generated metadata into the Kometa config mount. Its official
image publishes channel tags rather than release-version tags, so Duplex pins
the reviewed `latest` manifest digest and excludes that container from
Watchtower. Renovate proposes digest changes for review.

### Tautulli

Open `http://YOUR-NAS:8181` after the container starts. If the config directory
is not writable by the configured `PUID` and `PGID`, Tautulli's pilot episode
will be a permissions error with a very short runtime.

### Notifiarr

Open `http://YOUR-NAS:5454` and complete the first-run client setup. The static
`hostname: notifiarr` prevents duplicate client identities. The tracked sample
configuration contains placeholders only; keep the generated live
`notifiarr.conf` private.

### Watchtower

Watchtower can control the Docker daemon through `/var/run/docker.sock`. That is
effectively host-level authority, even when the mount is marked read-only.
Duplex limits the blast radius with `WATCHTOWER_LABEL_ENABLE=true` and explicit
service labels, but you should still review image release notes and keep tested
backups.

The separate one-shot chart performs one labeled update pass:

```sh
cp config/watchtower/example.env config/watchtower/.env
make watchtower-config
make watchtower-run
```

## Overlay Reset: the “are you absolutely sure?” special 💣

Kometa's documentation describes Overlay Reset as destructive with no undo.
Duplex therefore ships it separately, never restarts it automatically, and
defaults its example to `DRY_RUN="True"`.

```sh
cp config/overlay-reset/example.env config/overlay-reset/.env
make overlay-reset-config
make overlay-reset-run
```

Read the [Overlay Reset guide](config/overlay-reset/README.md), back up Plex, and
review the dry-run output before disabling dry-run mode. This is not the scene
for method acting.

## Updating the production 📦

Routine dependency updates arrive through Renovate pull requests. After an
approved change lands:

```sh
git pull --ff-only
git submodule update --init --recursive
make validate
make pull
make up
```

Back up application config and Plex data before version changes. Do not assume
a successful Compose render proves an application's database migration is safe.

## Repository checks 🧪

```sh
make validate
pre-commit run --all-files
git diff --check
```

These checks cover every Compose chart, environment-variable parity, secrets,
Markdown, YAML, shell, and GitHub Actions. There is no Duplex-owned Dockerfile,
so image-build and image-vulnerability gates from Privateerr and Plundarr do not
apply here.

## Documentation map 🗺️

- [Deployment and upgrade setup](SETUP.md)
- [Contributing](docs/CONTRIBUTING.md)
- [Security policy](docs/SECURITY.md)
- [Code of conduct](docs/CODE_OF_CONDUCT.md)
- [ImageMaid config](config/imagemaid/README.md)
- [Notifiarr config](config/notifiarr/README.md)
- [PATTRMM config](config/pattrmm/README.md)
- [Tautulli config](config/tautulli/README.md)
- [One-shot Watchtower](config/watchtower/README.md)

## License 📄

Duplex-owned files are licensed under Apache-2.0. Container images and the
Kometa configuration submodule remain under their respective upstream licenses.

```text
   __________________________
  | .----------------------. |
  | |                      | |
  | |   📺 Now Streaming   | |
  | |   🍿 Duplex Media    | |
  | |                      | |
  | '----------------------' |
  |__________________________|
    (_)                  (_)
```

May your metadata match, your posters remain uncursed, and your YAML never get
renewed for an unnecessary indentation arc. 🌟
