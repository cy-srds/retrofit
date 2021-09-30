#!/bin/bash
set -eu

# Install prerequiste software
apt-get update
apt-get upgrade -y
apt-get install -y python3.7 python3-pip python3-dev python3-venv make curl git udev libusb-0.1-4 libglu1
apt-get autoremove
apt-get autoclean
python3 -m pip install -U -r requirements.txt

# Download and install ModusToolbox
MTB_INSTALL_URL="https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3/ModusToolbox_2.3.0.4276-linux-install.tar.gz"
MTB_SETUP_FILE=${MTB_INSTALL_URL##*/}
curl --fail "-#" -O $MTB_INSTALL_URL
tar -xzf $MTB_SETUP_FILE
rm -f $MTB_SETUP_FILE

# Run the rules require by ModusToolbox (it makes more sense on a physical machine)
MTB_TOOLS_VERSION=$(echo $MTB_SETUP_FILE | awk -F_ '{ print $2 }' | awk -F. '{ print $1"."$2 }')
MTB_TOOLS_PATH=ModusToolbox/tools_$MTB_TOOLS_VERSION

sed -i "s,sudo ,,g" $MTB_TOOLS_PATH/openocd/udev_rules/install_rules.sh
sed -i "s,sudo ,,g" $MTB_TOOLS_PATH/driver_media/install_rules.sh
sed -i "s,sudo ,,g" $MTB_TOOLS_PATH/fw-loader/udev_rules/install_rules.sh

chmod +x $MTB_TOOLS_PATH/driver_media/install_rules.sh

$MTB_TOOLS_PATH/openocd/udev_rules/install_rules.sh
$MTB_TOOLS_PATH/driver_media/install_rules.sh
$MTB_TOOLS_PATH/fw-loader/udev_rules/install_rules.sh
$MTB_TOOLS_PATH/modus-shell/postinstall
