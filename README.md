# Mixtile HAOS

`mixtile-haos` is a thin overlay repository for building Home Assistant OS for Mixtile Edge 2.

## Layout

- `haos/`: upstream `home-assistant/operating-system` pinned to a stable release tag
- `external/`: Mixtile Edge 2 board support and patches
- `.github/workflows/`: build, sync, and historical backfill automation

## Branch model

- `main`: the only long-lived branch, always tracking the latest stable HAOS release line
- `port/<version>`: temporary historical or next-major adaptation branch, for example `port/11.5`
- release tags: `mixtile-haos-<haos-version>-r<revision>`

## Release policy

- historical majors are published once and then frozen
- historical backfill starts at `11.5`
- the fixed historical targets are `11.5`, `12.4`, `13.2`, `14.2`, `15.2`, `16.3`, and `17.1`
- future work stays on `main` and follows the latest stable HAOS release only

## Workflows

- `Build Mixtile Edge 2`: builds any `git_ref` and optionally creates or updates a draft GitHub Release when `release_tag` is provided
- `Sync latest HAOS release`: watches the latest official HAOS stable release and opens an issue when `main` is behind upstream
- `Backfill major release`: dispatches a build for one historical `port/<version>` branch at a time using the standard release tag format; the `port/<version>` branch must already be prepared and pushed
