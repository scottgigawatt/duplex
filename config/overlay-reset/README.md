# Kometa Overlay Reset: The Eraser Cut 🧹💣

Overlay Reset removes Kometa-applied overlays from Plex libraries. Upstream
describes it as destructive with no undo, so Duplex keeps it out of the primary
stack, disables automatic restarts, and makes the checked-in example a dry run.

## Before touching the big red button 🛡️

- Back up Plex application data.
- Read the official
  [Overlay Reset documentation](https://kometa.wiki/en/latest/kometa/scripts/overlay-reset/).
- Confirm `PLEX_URL`, `PLEX_LIBRARY`, and every optional selector.
- Keep `DRY_RUN="True"` for the first pass.
- Review the complete output before allowing writes.

## Rehearse the recovery 🎬

```sh
cp config/overlay-reset/example.env config/overlay-reset/.env
make overlay-reset-config
make overlay-reset-run
```

The container reads application settings from `/config/.env`, which is the same
private file used by Compose. Do not commit it.

Only after a clean backup and reviewed dry run should you set
`DRY_RUN="False"` and execute another one-shot run. The container exits when it
finishes and will not restart itself.

> [!CAUTION]
> This tool is the narrative equivalent of deleting the timeline. If the dry
> run surprises you, stop the show and fix the settings.
