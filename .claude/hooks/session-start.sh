#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# This repo is a collection of large GitHub Actions workflow YAML files
# (with embedded shell scripts) plus kernel source patches - there is no
# application dependency manifest. The relevant "linters" are actionlint
# (workflow syntax/semantics) and shellcheck (embedded run: steps).

if ! command -v shellcheck >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y --no-install-recommends shellcheck
fi

if ! command -v actionlint >/dev/null 2>&1; then
  bash <(curl -fsSL https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash) latest /usr/local/bin
fi
