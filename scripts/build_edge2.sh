#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cache_dir="${repo_root}/.cache"
output_dir="${repo_root}/output"
haos_dir="${repo_root}/haos"
buildroot_dir="${haos_dir}/buildroot"
br2_external="/build/haos/buildroot-external:/build/external"

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "This build wrapper must run on Linux." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required." >&2
  exit 1
fi

if [[ ! -d "${haos_dir}/buildroot-external" || ! -f "${repo_root}/external/configs/mixtile_edge2_defconfig" ]]; then
  echo "Repository layout is incomplete." >&2
  exit 1
fi

git -C "${repo_root}" submodule update --init --recursive

mkdir -p "${cache_dir}" "${output_dir}"

haos_tag=$(git -C "${haos_dir}" describe --tags --exact-match 2>/dev/null || git -C "${haos_dir}" rev-parse --short HEAD)
builder_image=${BUILDER_IMAGE:-"mixtile-haos-builder:${haos_tag}"}

docker build -t "${builder_image}" -f "${haos_dir}/Dockerfile" "${haos_dir}"

run_builder() {
  docker run --rm --privileged \
    -e BUILDER_UID="$(id -u)" \
    -e BUILDER_GID="$(id -g)" \
    -v "${repo_root}:/build" \
    -v "${cache_dir}:/cache" \
    -v "${output_dir}:/build/output" \
    "${builder_image}" \
    "$@"
}

run_builder make -C /build/haos/buildroot O=/build/output BR2_EXTERNAL="${br2_external}" mixtile_edge2_defconfig
run_builder make -C /build/haos/buildroot O=/build/output BR2_EXTERNAL="${br2_external}"

echo "Build completed. Artifacts are under ${output_dir}/images/"

