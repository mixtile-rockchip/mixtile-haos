# Release flow

This repository follows official stable HAOS releases.

## Update flow

1. Move `haos/` to the latest stable release tag with `scripts/sync_haos_release.sh`.
2. Run `scripts/build_edge2.sh` on the Linux build machine.
3. Verify the generated `haos_mixtile-edge2-<version>.img.xz` and `.raucb`.
4. Commit the updated `haos/` submodule pointer and any board fixes.
5. Push to GitHub.

## Build host

The primary build host is expected to be a Linux machine with:

- Docker access
- enough free disk space for Buildroot downloads and output
- outbound access to GitHub

## Scope

Only Mixtile Edge 2 board support lives in this repository. Common HAOS packages, scripts, and platform support stay in upstream `haos/buildroot-external`.

