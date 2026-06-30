#!/bin/bash

set -euo pipefail

# gn's build/gen.py hardcodes -mmacosx-version-min=14, newer than the SDK on
# PBP macOS builders. Lower it to the conda osx-arm64 floor so the bootstrap links.
if [[ "$(uname)" == "Darwin" ]]; then
    sed -i.bak "s/-mmacosx-version-min=14/-mmacosx-version-min=11.0/" build/gen.py
fi

python build/gen.py
ninja -C out
mkdir -p $PREFIX/bin
cp out/gn $PREFIX/bin/gn
