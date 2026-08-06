# PATTRMM's Scheduling Department 📅🎬

PATTRMM creates Returning Soon, In-History, and other metadata for Kometa. This
directory supplies its writable `/data` and `/preferences` mounts, while the
Kometa submodule is mounted at `/config` for generated metadata.

## Directory contract 📂

- [`data/`](data/README.md): generated history, cache, and logs.
- [`preferences/`](preferences/README.md): checked-in settings and generated
  templates.
- `config/kometa`: the separate Kometa configuration repository receiving
  PATTRMM output.

Set `PATTRMM_TIME`, `PATTRMM_PUID`, and `PATTRMM_PGID` in the root `.env`.
Upstream intentionally names the group variable `GUID`; Duplex maps the clearer
host setting to that required container variable.

> [!NOTE]
> Run PATTRMM before Kometa so the day's metadata is on set before Kometa starts
> filming it.

PATTRMM publishes `latest`, `develop`, and `nightly` image channels rather than
release-version tags. Duplex pins the reviewed `latest` multi-architecture
manifest digest and lets Renovate propose digest updates.

See the official [PATTRMM repository](https://github.com/InsertDisc/pattrmm) for
current settings and generated filename guidance.
