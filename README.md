# Mixtile HAOS

`mixtile-haos` is a thin overlay repository for building Home Assistant OS for Mixtile Edge 2.

## Layout

- `haos/`: upstream `home-assistant/operating-system` pinned to a stable release tag
- `external/`: Mixtile Edge 2 board support and patches
- `.github/major-targets.json`: the single source of truth for supported frozen release targets
- `.github/workflows/`: build, publish, and sync automation

## Branch model

- `main`: the only long-lived branch, always tracking the latest stable HAOS release line
- `port/<version>`: temporary frozen-release or next-major adaptation branch, currently `port/15.2`, `port/16.3`, and `port/17.1`
- `sync/<version>`: temporary branch created by automation when upstream HAOS stable moves ahead of `main`
- release tags: stable HAOS version tags such as `15.2`, `16.3`, and `17.1`

## Release policy

- only stable HAOS releases are tracked; rc, beta, and prerelease tags are ignored
- support starts at `15.2`
- releases below `15.2` are no longer maintained or published
- frozen stable releases are `15.2`, `16.3`, and `17.1`
- future work stays on `main` and follows the latest stable HAOS release only

## Workflows

- `Build Mixtile Edge 2`: the single build engine; it runs from workflow code on `main`, checks the actual build source out into `source/`, and either uploads validation artifacts or attaches assets to an existing release
- `Publish release`: tags a validated ref with the stable HAOS version, creates or updates the GitHub release, uploads assets, and deletes the matching `port/<version>` branch
- `Sync latest HAOS release`: creates `sync/<version>` and opens or updates a PR back to `main`
