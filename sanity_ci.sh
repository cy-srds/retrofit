#!/bin/bash
#
# This must be the first non-commented line in this script.
# It ensures bash doesn't choke due to '\r' EoL.
(set -o igncr) 2>/dev/null && set -o igncr;
# Enable bash strictures
set -ue
set -o pipefail
#################################################

export CyRemoteManifestOverride="https://raw.githubusercontent.com/Infineon/mtb-super-manifest/v2.X/mtb-super-manifest-fv2.xml"
make getlibs
make build
