#!/bin/bash
#
# This must be the first non-commented line in this script.
# It ensures bash doesn't choke due to '\r' EoL.
(set -o igncr) 2>/dev/null && set -o igncr;
# Enable bash strictures
set -ueo pipefail
#################################################

# Create a project for the given source and build it
CE_NAME="mtb-example-hal-pwm-square-wave"
CE_TARGET="CY8CKIT-062-BLE"
$CY_TOOLS_PATHS/project-creator/project-creator-cli --verbose 0 --board-id $CE_TARGET --app-id $CE_NAME --target-dir . --user-app-name mtbApp
cd mtbApp
make -j$(nproc) build
