#!/bin/sh

#
# Copyright 2025-2026 Scott Gigawatt
#
# Licensed under the Apache License, Version 2.0.
#
# check-config.sh: Verify Compose variable coverage, current image policy, and
#                  syntax conventions without reading private environment data.
#

set -eu

TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/duplex-config.XXXXXX")"
readonly TEMP_DIR

cleanup() {
    rm -rf "${TEMP_DIR}"
}

trap cleanup EXIT HUP INT TERM

extract_compose_variables() {
    compose_file=$1

    grep -Eo '\$\{[A-Z][A-Z0-9_]*\}' "${compose_file}" \
        | tr -d "{}$" \
        | sort -u
}

extract_environment_names() {
    environment_file=$1

    awk -F '=' '/^[A-Z][A-Z0-9_]*=/{print $1}' "${environment_file}" \
        | sort -u
}

check_pair() {
    compose_file=$1
    environment_file=$2
    pair_name=$3
    compose_variables="${TEMP_DIR}/${pair_name}.compose"
    environment_names="${TEMP_DIR}/${pair_name}.env"
    missing_names="${TEMP_DIR}/${pair_name}.missing"

    if [ ! -f "${compose_file}" ]; then
        echo "Missing Compose file: ${compose_file}" >&2
        exit 1
    fi

    if [ ! -f "${environment_file}" ]; then
        echo "Missing example environment file: ${environment_file}" >&2
        exit 1
    fi

    extract_compose_variables "${compose_file}" > "${compose_variables}"
    extract_environment_names "${environment_file}" > "${environment_names}"
    comm -23 "${compose_variables}" "${environment_names}" > "${missing_names}"

    if [ -s "${missing_names}" ]; then
        echo "${environment_file} is missing variables required by ${compose_file}:" >&2
        sed 's/^/  - /' "${missing_names}" >&2
        exit 1
    fi

    if grep -Eq '^[[:space:]]*version:' "${compose_file}"; then
        echo "${compose_file} uses the obsolete top-level Compose version field." >&2
        exit 1
    fi

    if grep -Eq '\$\{[A-Z][A-Z0-9_]*:-' "${compose_file}"; then
        echo "${compose_file} contains an inline default; move it to ${environment_file}." >&2
        exit 1
    fi

    if awk '/_IMAGE=/{if ($0 ~ /:latest/ && $0 !~ /@sha256:/) exit 1}' "${environment_file}"; then
        :
    else
        echo "${environment_file} contains an unpinned floating latest image." >&2
        exit 1
    fi
}

check_pair docker-compose.yml example.env root
check_pair \
    config/overlay-reset/docker-compose.yml \
    config/overlay-reset/example.env \
    overlay-reset
check_pair \
    config/watchtower/docker-compose.yml \
    config/watchtower/example.env \
    watchtower

echo "All Duplex Compose and example environment contracts are aligned."
