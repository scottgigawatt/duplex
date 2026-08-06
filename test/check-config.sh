#!/bin/sh

#
# Copyright 2025-2026 Scott Gigawatt
#
# Licensed under the Apache License, Version 2.0.
#
# check-config.sh: Verify Compose variable coverage, current image policy, and
#                  syntax conventions without reading private environment data.
#
# The script:
#   - Creates an isolated temporary workspace for normalized variable lists.
#   - Extracts required variable names from each Compose file.
#   - Extracts defined variable names from the matching example environment.
#   - Reports variables required by Compose but missing from its example.
#   - Rejects obsolete Compose version fields and inline fallback defaults.
#   - Rejects floating latest image references that lack an immutable digest.
#   - Removes temporary validation files on success, failure, or interruption.
#
# Run the script from the repository root so relative chart paths resolve.
#
# Usage: test/check-config.sh
#

#
# Stop immediately on a failed command or an unset variable.
#
set -eu

#
# Keep generated comparison files outside the repository and make the resolved
# path immutable so cleanup cannot be redirected later in the script.
#
TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/duplex-config.XXXXXX")"
readonly TEMP_DIR

#
# Remove the temporary comparison workspace created for this validation run.
#
cleanup() {
    rm -rf "${TEMP_DIR}"
}

#
# Run cleanup for normal exits, command failures, and common termination signals.
#
trap cleanup EXIT HUP INT TERM

#
# Print the unique environment variable names referenced by a Compose file.
#
extract_compose_variables() {
    compose_file=$1

    grep -Eo '\$\{[A-Z][A-Z0-9_]*\}' "${compose_file}" \
        | tr -d "{}$" \
        | sort -u
}

#
# Print the unique variable names assigned by an example environment file.
#
extract_environment_names() {
    environment_file=$1

    awk -F '=' '/^[A-Z][A-Z0-9_]*=/{print $1}' "${environment_file}" \
        | sort -u
}

#
# Validate one Compose file and its matching example environment contract.
#
check_pair() {
    compose_file=$1
    environment_file=$2
    pair_name=$3

    #
    # Give every normalized list a pair-specific path so one validation cannot
    # overwrite another pair's evidence.
    #
    compose_variables="${TEMP_DIR}/${pair_name}.compose"
    environment_names="${TEMP_DIR}/${pair_name}.env"
    missing_names="${TEMP_DIR}/${pair_name}.missing"

    #
    # Fail with the missing path before running tools that would emit a less
    # useful file-not-found diagnostic.
    #
    if [ ! -f "${compose_file}" ]; then
        printf 'Missing Compose file: %s\n' "${compose_file}" >&2
        exit 1
    fi

    if [ ! -f "${environment_file}" ]; then
        printf 'Missing example environment file: %s\n' "${environment_file}" >&2
        exit 1
    fi

    #
    # Normalize both variable sets, then retain only Compose requirements that
    # the checked-in example does not define.
    #
    extract_compose_variables "${compose_file}" > "${compose_variables}"
    extract_environment_names "${environment_file}" > "${environment_names}"
    comm -23 "${compose_variables}" "${environment_names}" > "${missing_names}"

    #
    # Keep failure output limited to variable names; never read or print a
    # deployment's private environment values.
    #
    if [ -s "${missing_names}" ]; then
        printf '%s is missing variables required by %s:\n' \
            "${environment_file}" \
            "${compose_file}" >&2
        sed 's/^/  - /' "${missing_names}" >&2
        exit 1
    fi

    #
    # Modern Compose specifications infer the schema and reject the obsolete
    # top-level version field as repository policy.
    #
    if grep -Eq '^[[:space:]]*version:' "${compose_file}"; then
        printf '%s uses the obsolete top-level Compose version field.\n' \
            "${compose_file}" >&2
        exit 1
    fi

    #
    # Defaults belong in the paired example so operators have one complete,
    # reviewable settings contract instead of hidden Compose fallbacks.
    #
    if grep -Eq '\$\{[A-Z][A-Z0-9_]*:-' "${compose_file}"; then
        printf '%s contains an inline default; move it to %s.\n' \
            "${compose_file}" \
            "${environment_file}" >&2
        exit 1
    fi

    #
    # Allow a latest channel only when an immutable digest fixes its contents.
    #
    if awk '/_IMAGE=/{if ($0 ~ /:latest/ && $0 !~ /@sha256:/) exit 1}' "${environment_file}"; then
        :
    else
        printf '%s contains an unpinned floating latest image.\n' \
            "${environment_file}" >&2
        exit 1
    fi
}

#
# Validate the primary stack and every repository-owned one-shot chart.
#
check_pair docker-compose.yml example.env root
check_pair \
    config/overlay-reset/docker-compose.yml \
    config/overlay-reset/example.env \
    overlay-reset
check_pair \
    config/watchtower/docker-compose.yml \
    config/watchtower/example.env \
    watchtower

#
# Report one concise success line after every contract and policy check passes.
#
printf '%s\n' "All Duplex Compose and example environment contracts are aligned."
