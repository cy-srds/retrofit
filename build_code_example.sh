#!/bin/bash
set -eu

# Clone a ModusToolbox code example, fetch the libraries and then build it
CE_NAME="mtb-example-psoc6-pwm-square-wave"
git clone https://github.com/Infineon/$CE_NAME.git
cd $CE_NAME
make getlibs
make -j$(nproc) build
