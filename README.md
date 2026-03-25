# Mixtile HAOS

`mixtile-haos` is a thin overlay repository for building Home Assistant OS for Mixtile Edge 2.

## Layout

- `haos/`: upstream `home-assistant/operating-system` pinned to a stable release tag
- `external/`: Mixtile Edge 2 board support and patches
- `.github/major-targets.json`: the single source of truth for historical major backfill targets
- `.github/workflows/`: build, sync, backfill, draft-release, and finalize-release automation

## Branch model

- `main`: the only long-lived branch, always tracking the latest stable HAOS release line
- `port/<version>`: temporary historical or next-major adaptation branch, for example `port/11.5`
- `sync/<version>`: temporary branch created by automation when upstream HAOS stable moves ahead of `main`
- release tags: `mixtile-haos-<haos-version>-r<revision>`

## Release policy

- only stable HAOS releases are tracked; rc, beta, and prerelease tags are ignored
- historical majors are published once and then frozen
- historical backfill starts at `11.5`
- only the final patch release of each historical major is published: `11.5`, `12.4`, `13.2`, `14.2`, `15.2`, `16.3`, and `17.1`
- future work stays on `main` and follows the latest stable HAOS release only

## Workflows

- `Build Mixtile Edge 2`: the single build engine; it always runs from workflow code on `main`, but checks the actual build source out into `source/`
- `Backfill major release`: validates one historical `port/<version>` branch at a time using `.github/major-targets.json`
- `Publish validated release`: tags a validated ref as `mixtile-haos-<haos-version>-r<revision>`, creates or updates a draft release, and uploads assets to that draft release
- `Finalize release`: publishes a board-validated draft release and deletes the matching `port/<version>` branch
- `Sync latest HAOS release`: creates `sync/<version>`, dispatches validate, and opens or updates a PR back to `main`
