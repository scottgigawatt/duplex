# Notifiarr's Production Pager 🔔📺

This directory is mounted at `/config` inside Notifiarr. On first run, the
container can generate `notifiarr.conf`, which can contain API keys, application
credentials, private hosts, and other material that should never audition for a
public repository.

## First run 🎬

1. Start the primary Duplex stack with `make up`.
2. Open `http://YOUR-NAS:5454`.
3. Complete the Notifiarr client setup.
4. Keep `hostname: notifiarr` unchanged so the site retains one client identity.

The tracked [`notifiarr.conf.example`](notifiarr.conf.example) is an upstream-
style placeholder reference. Do not put real credentials in it. This change
preserves the historical tracked `notifiarr.conf` unchanged so an update cannot
remove an existing installation's configuration. The ignore rule protects new
untracked copies but cannot untrack that historical file; existing users should
therefore continue treating local changes to it as private and never commit
credentials.

> [!WARNING]
> Redact the API key, UI credentials, webhook destinations, upstream service
> keys, Plex tokens, and private network details before sharing diagnostics.

The `/var/run/utmp` and `/etc/machine-id` mounts support logged-in-user counts
and a stable machine identity. They are read-only in the Duplex chart.

See the official [Notifiarr installation guide](https://notifiarr.wiki/pages/client/install/)
and [first-run guidance](https://notifiarr.wiki/pages/client/afterInstall/).
