# PATTRMM Preferences: Notes from Standards & Practices 📋

PATTRMM mounts this directory at `/preferences`. The checked-in
[`settings.yml`](settings.yml) configures libraries, metadata output, overlay
placement, date formatting, and optional status overlays.

Review library names against Plex and output folders against the Kometa config
before starting the container. PATTRMM may generate additional template files
here as upstream features evolve.

> [!IMPORTANT]
> Back up local preference changes before replacing templates during an upgrade.
> Upstream release notes may require renamed metadata files or regenerated
> templates.

See the official [PATTRMM settings reference](https://github.com/InsertDisc/pattrmm#settings-file)
for every supported field.
