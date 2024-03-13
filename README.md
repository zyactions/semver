# SemVer

![License: MIT][shield-license-mit]
[![CI][shield-ci]][workflow-ci]
[![Ubuntu][shield-platform-ubuntu]][job-runs-on]
[![macOS][shield-platform-macos]][job-runs-on]
[![Windows][shield-platform-windows]][job-runs-on]

A GitHub Action that provides access to the individual parts of a SemVer2 version string.

## Features

- Provides access to the individual parts of a [SemVer2][semver] version string
- Supports removal of unwanted prefixes
- Fast execution
- Supports all platforms (Linux, macOS, Windows)
- Does not use external GitHub Actions dependencies

## Usage

### Parse semantic version

```yaml
steps:
  - name: Parse version
    id: version
    uses: zyactions/semver@v1
    with:
      version: '1.2.3-alpha.1+build'

  - name: Print major version
    run: |-
      echo "Major: ${{ steps.outputs.version.major }}"
```

> Note:
>
> If the `version` starts with `refs/` and/or `tags/`, the prefix is automatically removed so that Git references can easily be used as input.

## Inputs

### `version`

A string containing the semantic version to parse.

For example:

- `1.2.3-alpha.1+build`
- `v2.3.4`
- `refs/tags/v2.3.4`

Defaults to `GITHUB_REF` if not specified.

### `prefixes`

An optional newline separated list of version prefixes to strip from the input version (e.g. `v` or `release-v`).

### `fail-on-error`

Set `true` to fail, if the input `version` does not contain a valid semantic version.

Defaults to `true`.

## Outputs

### `valid`

Signals, if the input `version` contained a valid semantic version.

### `version`

The (sanitized) semantic version string with any prefix trimmed from it.

For example: `1.2.3-alpha.1+build`

### `major`

The major version.

For example: `1`

### `minor`

The minor version.

For example: `2`

### `patch`

The patch version.

For example: `3`

### `prerelease`

The prerelease version part.

For example: `alpha.1`

### `build`

The build/metadata version part.

For example: `build`

## Dependencies

This action does not use external GitHub Actions dependencies.

Internal dependencies:

- [semver-tool][semver-tool] (bundled)

## Versioning

Versions follow the [semantic versioning scheme][semver].

## License

SemVer Action is licensed under the MIT license.

[job-runs-on]: https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on
[semver]: https://semver.org
[semver-tool]: https://github.com/fsaintjacques/semver-tool
[shield-license-mit]: https://img.shields.io/badge/License-MIT-blue.svg
[shield-ci]: https://github.com/zyactions/semver/actions/workflows/ci.yml/badge.svg
[shield-platform-ubuntu]: https://img.shields.io/badge/Ubuntu-E95420?logo=ubuntu\&logoColor=white
[shield-platform-macos]: https://img.shields.io/badge/macOS-53C633?logo=apple\&logoColor=white
[shield-platform-windows]: https://img.shields.io/badge/Windows-0078D6?logo=windows\&logoColor=white
[workflow-ci]: https://github.com/zyactions/semver/actions/workflows/ci.yml
