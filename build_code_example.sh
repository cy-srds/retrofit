#!/bin/bash
set -eu

git clone https://github.com/Infineon/mtb-example-psoc6-pwm-square-wave.git
cd mtb-example-psoc6-pwm-square-wave
make getlibs
make -j$(nproc) build
