#!/bin/sh
# Lance toute la verification : tests Node, construction de l'appareil, controles statiques.
set -e
cd "$(dirname "$0")/.."
for t in test_core test_engine test_ui test_glue; do node tests/$t.js | tail -1; done
python3 tools/build_device.py
python3 tools/check_device.py
