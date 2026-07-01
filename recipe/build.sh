#!/bin/bash

set -euo pipefail

# gn's build/gen.py hardcodes -mmacosx-version-min=14, newer than the SDK on
# PBP macOS builders. Lower it to the conda osx-arm64 floor so the bootstrap links.
if [[ "$(uname)" == "Darwin" ]]; then
    sed -i.bak "s/-mmacosx-version-min=14/-mmacosx-version-min=11.0/" build/gen.py
fi

# Drop -Werror from the bootstrap: conda's GCC on Linux flags a benign multi-line
# comment in the gn source (-Werror=comment) that upstream's clang build doesn't.
sed -i.werror.bak "s/cflags.append('-Werror')/pass  # -Werror dropped for conda GCC/" build/gen.py

python build/gen.py
ninja -C out
mkdir -p $PREFIX/bin
cp out/gn $PREFIX/bin/gn
