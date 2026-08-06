# ImageMaid's Digital Broom Closet 🧼🎬

This directory is mounted at `/config` inside ImageMaid. It holds the private
application `.env`, logs, and maintenance state while ImageMaid cleans Plex's
image cache with the intensity of a production assistant who just found glitter
in the continuity photos.

## Setup 🛠️

```sh
cp config/imagemaid/example.env config/imagemaid/.env
```

Edit the private file and replace at least:

- `PLEX_URL`
- `PLEX_TOKEN`
- the schedule and cleanup modes appropriate for the server

The main Compose chart mounts `HOST_PLEX_CONFIG` at `/plex`. That host path must
contain Plex's `Cache`, `Metadata`, and `Plug-in Support` directories.

> [!WARNING]
> ImageMaid changes Plex application data. Back up Plex, verify the mount, and
> start with conservative modes. A misplaced path can turn spring cleaning into
> a season finale.

Keep `config/imagemaid/.env`, generated logs, and Plex tokens out of git. The
checked-in [`example.env`](example.env) contains placeholders only.

See the official [ImageMaid documentation](https://kometa.wiki/en/latest/kometa/scripts/imagemaid/)
for current modes, schedules, and safety guidance.
