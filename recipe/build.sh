#!/bin/bash

set -euo pipefail

python build/gen.py --no-static-libstdc++ --allow-warnings
ninja -C out
mkdir -p $PREFIX/bin
cp out/gn $PREFIX/bin/gn
