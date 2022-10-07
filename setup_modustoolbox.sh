#!/bin/bash
set -eu

# Install prerequisite software
apt-get update && apt-get upgrade -y
apt-get install -y python3.8 python3-pip make curl git libncurses5 libxcb-xinerama0 libusb-1.0-0
apt-get autoremove && apt-get autoclean
python3 -m pip install --no-cache-dir -r requirements.txt

# Download and install ModusToolbox
MTB_INSTALL_URL="https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.4/ModusToolbox_2.4.0.5972-linux-install.tar.gz"
MTB_SETUP_FILE=${MTB_INSTALL_URL##*/}
curl --fail "-#" -O $MTB_INSTALL_URL
tar -xzf $MTB_SETUP_FILE
rm -f $MTB_SETUP_FILE

# Run the rules required by ModusToolbox
ModusToolbox/tools_2.4/modus-shell/postinstall
