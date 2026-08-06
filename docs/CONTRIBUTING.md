# Contributing to Duplex 🎬📺

Welcome to the writers' room. Duplex is a small self-hosted production, so a
good contribution should be understandable at 2 a.m. while Docker insists the
problem is “probably networking.”

## Before writing the episode 🍿

- Read the root [README](../README.md) and [setup guide](../SETUP.md).
- Read the [security policy](SECURITY.md) before sharing logs or config.
- Follow the [code of conduct](CODE_OF_CONDUCT.md).
- Search existing issues and pull requests for the same plot.
- Read [`AGENTS.md`](../AGENTS.md) for repository-specific rules.

## What belongs here? 🧭

Welcome contributions include:

- Compose improvements that preserve Synology Container Manager compatibility.
- Safer defaults and clearer migration guidance.
- Current upstream image, configuration, or deployment updates.
- Validation, secret-handling, and supply-chain improvements.
- Documentation that prevents real setup mistakes.

Please discuss large service additions or architectural rewrites first. Every
new container brings another image source, upgrade policy, state directory,
security boundary, and supporting actor who wants top billing.

## Repository boundaries 🛡️

`config/kometa` is a git submodule. Commit its content changes in the
`kometa-config` repository; Duplex should usually update only the submodule
pointer.

Do not commit:

- private `.env` files
- Plex tokens or Notifiarr API keys
- webhook URLs or registry credentials
- generated Notifiarr config
- application databases, logs, caches, exports, or backups
- private hostnames, IP addresses, or library details

## Local setup 🛠️

```sh
git clone --recurse-submodules git@github.com:scottgigawatt/duplex.git
cd duplex
cp example.env .env
pre-commit install
```

Use placeholders and safe test paths. Do not point a development run at live
Plex data unless the change explicitly requires it and a current backup exists.

## Style and comments ✍️

- Public Markdown may use Duplex's movie-and-television humor.
- Code and configuration comments stay plain, precise, and technical.
- Project-owned config files begin with copyright, Apache-2.0, and filename
  summary comments where their format supports comments.
- Inline Compose comments use two spaces before `#` and align within logical
  groups.
- Shell scripts use POSIX `sh`, `set -eu`, four-space indentation, and quoted
  expansions unless documented otherwise.
- Compose defaults belong in example environment files, not inline fallback
  expressions.
- Keep stable container names and explicit read/write mount modes.
- Keep GitHub Actions pinned to full commit SHAs.

## Validation 🧪

Before opening a pull request, run:

```sh
make help
make validate
pre-commit run --all-files
git diff --check
```

If behavior changes, also render a private synthetic deployment and exercise the
smallest safe affected service workflow. A Compose render is necessary, but it
does not prove application migration safety.

## Dependencies and releases 📦

Let Renovate manage routine updates for container images, GitHub Actions,
pre-commit hooks, and the Kometa submodule. For a manual update:

1. Link the official release or deployment documentation.
2. Explain migration and rollback implications.
3. Preserve current platform support.
4. Validate every Compose chart and repository hook.

## Pull requests 🎟️

A useful pull request explains:

- what changed
- why it changed
- user and deployment impact
- migration or rollback steps
- security implications
- exact validation performed

Keep unrelated local changes out of the commit. The `.vscode/settings.json`
spell list is not a free bonus feature just because it was sitting in the green
room.

Thanks for helping Duplex survive another season with fewer plot holes and
cleaner YAML. 🌟
