# Tautulli's Ratings Department 📊🍿

This directory is mounted at `/config` for Tautulli's database, settings,
backups, and logs. In other words, this is where the show about watching shows
keeps its extremely serious paperwork.

## First run 🎬

1. Set `TAUTULLI_PUID`, `TAUTULLI_PGID`, and `TAUTULLI_PORT` in the root `.env`.
2. Ensure the selected host identity can write this directory.
3. Start Duplex with `make up`.
4. Open `http://YOUR-NAS:8181` and complete setup.

Back up this directory before image upgrades. Never commit Tautulli's database,
logs, authentication settings, Plex token, or user activity.

See the official [Tautulli installation guide](https://docs.tautulli.com/getting-started/installation)
for Docker, Synology, UID/GID, port, and upgrade guidance.
