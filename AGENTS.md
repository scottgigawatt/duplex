<!--
  Copyright 2025-2026 Scott Gigawatt

  Licensed under the Apache License, Version 2.0.

  AGENTS.md: Contributor and AI-agent operating instructions for Duplex.
  -->

# AGENTS.md

## Project Purpose

Duplex is a Docker Compose toolkit for Plex-adjacent automation on Synology
Container Manager and ordinary Docker Compose hosts. It runs Kometa,
ImageMaid, PATTRMM, Tautulli, Notifiarr, and Watchtower, with separate one-shot
charts for Kometa Overlay Reset and Watchtower.

Duplex does not deploy Plex Media Server itself. It mounts an existing Plex
application-data directory and connects to an existing Plex server through the
individual tools' configuration.

## Repository Layout

- `docker-compose.yml`: Primary Duplex service stack.
- `example.env`: Complete example settings for the primary stack.
- `config/kometa/`: Kometa configuration git submodule. Treat it as a separate
  repository with its own history and policies.
- `config/overlay-reset/`: Destructive, one-shot overlay recovery chart.
- `config/watchtower/`: One-shot Watchtower chart.
- `config/*/README.md`: Service-specific setup and state-directory guidance.
- `test/`: Repository-owned validation scripts.
- `docs/`: Contribution, conduct, and security policies.
- `.github/`: Workflows, Renovate configuration, templates, and ownership.

## Code Ownership Boundaries

Do not edit files inside `config/kometa/` unless the explicit task is to change
the `kometa-config` project. Update the submodule pointer from the Duplex
repository; commit Kometa configuration changes in the submodule repository.

Private `.env` files and application-generated files are deployment state.
Never replace or normalize them while modernizing repository examples. Do not
commit Plex tokens, API keys, webhook URLs, Notifiarr client configuration,
databases, logs, caches, or exported metadata.

## Documentation Voice

Public-facing Markdown uses Duplex's established movie-and-television voice:
funny, energetic, readable, and operationally useful. Production jokes belong
in:

- `README.md`
- `SETUP.md`
- files under `docs/`
- config-directory README files
- GitHub issue and pull request templates
- user-facing Makefile output when appropriate

Do not let jokes obscure commands, paths, warnings, security boundaries, or
troubleshooting. Use GitHub callouts when they improve scanning.

## Code Comment Style

Code and configuration comments use concise plain English, never the public
theme. Comments should explain intent, constraints, safety boundaries, and
non-obvious behavior instead of narrating obvious assignments.

Project-owned scripts, Compose files, environment examples, Makefiles, and
repository configuration files should begin with the established copyright,
Apache-2.0, and filename-summary block.

Inline Compose comments use two spaces before `#`. Align the `#` characters
for logically grouped lines. Prefer section comments over an end-of-line
comment when the explanation would make the line difficult to scan.

## Shell And Make Rules

Project-owned host scripts use:

- `#!/bin/sh`
- POSIX-compatible syntax
- `set -eu` unless a documented behavior requires otherwise
- four-space indentation
- direct, actionable diagnostic errors

Place one blank line after the shebang before the top-of-file comment. Quote
variable expansions unless intentional field splitting is documented.

Keep Makefile variables centralized near the top. Every target should have the
established framed comment and dependency notes. User-facing target output may
use light production humor; failures must state the problem and correction.

## Docker Compose Rules

Synology DSM Container Manager compatibility is a core constraint. The primary
deployment remains one complete `docker-compose.yml` file.

Compose conventions:

- omit the obsolete top-level `version` field
- keep image references configurable through example environment files
- define defaults in environment files, not inline Compose fallback syntax
- prefer current release tags over floating `latest` when upstream publishes
  versioned images
- use stable container names that do not change with image tags
- use YAML anchors only for settings shared by multiple services
- keep environment variables ordered to match their Compose consumers
- use `:ro` for read-only bind mounts and `:rw` only when writes are required
- scope Watchtower updates with explicit labels
- document any Docker socket mount as host-equivalent access

The one-shot Overlay Reset chart must default to dry-run behavior. Its official
documentation describes the tool as destructive and without an undo path.

## GitHub And Dependency Rules

GitHub Actions must be pinned to full commit SHAs with a nearby release comment.
Workflows use least-privilege `permissions`, disable persisted checkout
credentials, and keep technical comments in plain English.

Renovate owns GitHub Action, Compose image, pre-commit hook, and Kometa
submodule updates. Do not add Dependabot configuration for the same sources.

The repository has no owned application image. Do not copy image-build,
multi-architecture build, SBOM, provenance, Hadolint, or Trivy image gates from
sibling projects unless Duplex gains a Dockerfile or publishable image.

## Validation Expectations

For documentation-only changes, run:

```sh
pre-commit run --all-files
git diff --check
```

For Compose, environment, workflow, or repository-policy changes, run:

```sh
make help
make validate
pre-commit run --all-files
git diff --check
```

`make validate` must use checked-in example files. Do not render the private
root `.env` into logs or CI output.

## Branch And Pull Request Conventions

Use funny movie- or television-themed branch and commit names when practical.
Commit messages should begin with an emoji, remain concise, and still describe
the change.

Pull request descriptions should lead with the operational change, call out
migration or security implications, and list the exact validation performed.

## Licensing

Duplex-owned files are Apache-2.0. The Kometa configuration submodule and every
containerized application remain under their own licenses. Do not imply that
Duplex relicenses third-party code or images.
