#!/bin/bash
set -eu

# Install prerequisite software
apt-get update
apt-get upgrade -y
apt-get install -y python3.7 python3-pip make curl git libncurses5 libxcb-xinerama0 libglu1 libglib2.0
apt-get autoremove
apt-get autoclean
python3 -m pip install --no-cache-dir -U -r requirements.txt

# Download and install ModusToolbox
MTB_INSTALL_URL="https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.4/ModusToolbox_2.4.0.5972-linux-install.tar.gz"
MTB_SETUP_FILE=${MTB_INSTALL_URL##*/}
curl --fail "-#" -O $MTB_INSTALL_URL
tar -xzf $MTB_SETUP_FILE
rm -f $MTB_SETUP_FILE

# Run the rules required by ModusToolbox
MTB_TOOLS_VERSION=$(echo $MTB_SETUP_FILE | awk -F_ '{ print $2 }' | awk -F. '{ print $1"."$2 }')
MTB_TOOLS_PATH=ModusToolbox/tools_$MTB_TOOLS_VERSION
$MTB_TOOLS_PATH/modus-shell/postinstall
