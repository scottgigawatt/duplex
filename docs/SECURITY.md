# Duplex Security Policy 🛡️📺

Security bugs are the episodes where nobody should live-tweet the twist. Please
report sensitive findings privately and keep dangerous details out of public
issues, pull requests, Discord channels, and logs.

## Supported versions 🎬

Duplex supports the current `main` branch and the image references checked into
its current `example.env` files.

| Version                                               | Supported |
| ----------------------------------------------------- | --------- |
| Current `main` branch                                 | ✅        |
| Current checked-in image references                   | ✅        |
| Older commits and local image overrides               | ❌        |
| Modified third-party images or Kometa submodule forks | ❌        |

Security fixes target the current chart rather than maintaining multiple old
production cuts.

## Report a vulnerability privately 🔐

Use GitHub's private vulnerability reporting:

1. Open the repository's **Security** tab.
2. Choose **Report a vulnerability**.
3. Include clear reproduction steps, affected files, relevant image references,
   and safely redacted logs.

If the feature is unavailable, ask for a private reporting channel through
[🔥HADES🔥](https://discord.gg/BpEGzWwGYf) without posting sensitive details.

Do not open a public issue for credential exposure, Docker socket abuse,
authentication bypasses, malicious image behavior, or a weakness that could
help attack a deployment.

## Never include these props 🚫

- Plex tokens
- Notifiarr API keys or UI credentials
- Watchtower notification URLs
- Docker registry credentials or `config.json`
- generated application config
- private hostnames, public IP addresses, or infrastructure maps
- application databases, logs, library activity, or user information

When in doubt, replace the value and describe its format.

## What Duplex controls 🔎

Duplex owns Compose charts, safe examples, documentation, validation scripts,
and repository automation. It does not build or publish the service images.
Image vulnerabilities should also be reported to the relevant upstream project.

The Kometa configuration is a separate git submodule. Report vulnerabilities in
that content to its repository while coordinating any necessary Duplex pointer
update.

## Supply-chain controls 📦

The repository uses:

- full commit SHA pins for GitHub Actions
- Renovate for images, actions, pre-commit hooks, and submodules
- a reviewed digest for PATTRMM because upstream publishes only channel tags
- CodeQL analysis for GitHub Actions
- OpenSSF Scorecard reporting
- Gitleaks and detect-secrets
- strict YAML, actionlint, ShellCheck, and Markdown validation
- least-privilege GitHub workflow permissions

Most services use current versioned image tags so releases remain readable and
Watchtower can pick up a rebuilt tag. Tags are not immutable; review upstream
release notes, keep backups, and use a digest override when an environment needs
fully reproducible pulls.

## Docker socket warning 💣

Watchtower controls Docker through `/var/run/docker.sock`. Access to that socket
can lead to host control. The `:ro` or `:rw` bind suffix controls the filesystem
mount point, not the Docker API methods available through the socket.

Duplex reduces accidental scope by enabling label filtering, explicitly opting
in eligible services, excluding Watchtower itself, and excluding digest-pinned
PATTRMM. This does not turn an untrusted updater into a sandbox.

## Destructive maintenance tools 🧹

Kometa Overlay Reset is destructive and has no undo according to its official
documentation. Duplex isolates it in a one-shot chart, disables restart, and
ships `DRY_RUN="True"` in the example. Users still need a verified Plex backup
and a reviewed dry run.

## Response expectations ⏱️

This is a small maintainer production. The goal is to:

- acknowledge credible private reports within seven days
- confirm scope and affected configurations
- coordinate with upstream projects when their image is responsible
- publish a fix and clear migration guidance when Duplex is responsible
- credit reporters when requested and safe

If a report is declined, the maintainer will try to explain why without
revealing details that put other deployments at risk.
