#!/bin/bash

# Inputs:
#   - version
#   - prefixes

# Outputs:
#   - version
#   - major
#   - minor
#   - patch
#   - prerelease
#   - build

set -e
set -u
set -o pipefail
shopt -s inherit_errexit

if [[ -z "$INPUT_VERSION" ]]; then
    echo "::error ::Missing mandatory 'version' input."
    exit 1
fi

version="$INPUT_VERSION"

echo "Input version: '$version'"

version="${version#refs/}"
version="${version#tags/}"
version="${version#$INPUT_PREFIX}" #TODO: Multiple

echo "Input version sanitized: '$version'"

semvertool="$GITHUB_ACTION_PATH/semver-tool/semver.sh"

status=$("$semvertool" validate "$version")
if [[ "$status" == "valid" ]]; then
    echo "valid=true" >> $GITHUB_OUTPUT
else
    echo "valid=false" >> $GITHUB_OUTPUT

    if [[ "$INPUT_FAIL_ON_ERROR" != "true" ]]; then
        exit 0
    fi

    echo "::error ::Version '$version' does not match the semver scheme 'X.Y.Z(-PRERELEASE)(+BUILD)'"
    exit 1
fi

major=$("$semvertool" get major "$version")
minor=$("$semvertool" get minor "$version")
patch=$("$semvertool" get patch "$version")
prerelease=$("$semvertool" get prerelease "$version")
build=$("$semvertool" get build "$version")

echo "version=$version" >> $GITHUB_OUTPUT
echo "major=$major" >> $GITHUB_OUTPUT
echo "minor=$minor" >> $GITHUB_OUTPUT
echo "patch=$patch" >> $GITHUB_OUTPUT
echo "prerelease=$prerelease" >> $GITHUB_OUTPUT
echo "build=$build" >> $GITHUB_OUTPUT
