#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
haos_dir="${repo_root}/haos"

if [[ ! -d "${haos_dir}/.git" && ! -f "${haos_dir}/.git" ]]; then
  echo "Missing haos submodule. Run git submodule update --init --recursive first." >&2
  exit 1
fi

resolve_latest_tag() {
  if command -v gh >/dev/null 2>&1; then
    gh api repos/home-assistant/operating-system/releases/latest --jq '.tag_name'
    return
  fi

  curl -fsSL https://api.github.com/repos/home-assistant/operating-system/releases/latest \
    | sed -n 's/.*"tag_name": "\([^"]*\)".*/\1/p' \
    | head -n 1
}

target_tag=${1:-$(resolve_latest_tag)}

if [[ -z "${target_tag}" ]]; then
  echo "Unable to resolve the target HAOS tag." >&2
  exit 1
fi

git -C "${haos_dir}" fetch --tags origin
git -C "${haos_dir}" checkout "${target_tag}"
git -C "${repo_root}" submodule update --init --recursive

echo "haos submodule moved to ${target_tag}"

