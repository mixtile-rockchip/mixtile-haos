# Mixtile HAOS

`mixtile-haos` is a thin overlay repository for building Home Assistant OS for Mixtile Edge 2.

## Layout

- `haos/`: upstream `home-assistant/operating-system` pinned to a stable release tag
- `external/`: Mixtile Edge 2 board support and patches
- `scripts/`: local sync and build helpers

## Build

The first build is intended to run on a Linux machine with Docker.

```bash
git submodule update --init --recursive
scripts/build_edge2.sh
```

Artifacts are written to `output/images/`.

## Sync upstream

To move the `haos/` submodule to the latest stable HAOS release:

```bash
scripts/sync_haos_release.sh
```

To pin a specific HAOS release tag:

```bash
scripts/sync_haos_release.sh 17.1
```

