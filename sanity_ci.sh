#!/bin/bash
#
# This must be the first non-commented line in this script.
# It ensures bash doesn't choke due to '\r' EoL.
(set -o igncr) 2>/dev/null && set -o igncr;
# Enable bash strictures
set -ue
set -o pipefail
#################################################

# Update the list of files that should not copied to project
CE_DISCARD_FILES=(app_source .git* *.yml .gitignore *.md *.sh)
mkdir app_source
# Copy the CE contents
for FILE_DIR in $(ls -A); do
    # Exclude the folders/files in CE repo that need not be copied
    f_file_found=0
    for FILE_NAME in "${CE_DISCARD_FILES[@]}"; do
        if [[ $FILE_NAME == "$FILE_DIR" ]]; then
            f_file_found=1
        fi
    done
    # Copy the code example source files to newly created project directory
    if [[ $f_file_found -eq 0 ]]; then
        cp -rf "$FILE_DIR" app_source
    fi
done

# Get the target name from the make file
CE_TARGET=""
if [[ -f common.mk ]]; then
    CE_TARGET=$(grep "^TARGET=.*$" common.mk | awk -F= '{ print $2 }' | tr -d '[:space:]')
else
    CE_TARGET=$(grep "^TARGET=.*$" [Mm]akefile | awk -F= '{ print $2 }' | tr -d '[:space:]')
fi
# Create a project for the given source and build it
/app/ModusToolbox/tools_3.0/project-creator/project-creator-cli --verbose 0 --board-id "$CE_TARGET" --app-path ./app_source --target-dir . --user-app-name MyApp
cd MyApp
make -j$(nproc) build
