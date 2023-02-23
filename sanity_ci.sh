#!/bin/bash
set -ueo pipefail
#################################################

export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH=${CY_TOOLS_PATHS}/gcc

cd /home

export DEBIAN_FRONTEND=noninteractive
apt-get -yq install git cmake ninja-build gperf ccache dfu-util device-tree-compiler wget \
    xz-utils file python3-dev python3-pip python3-setuptools python3-tk python3-wheel

pip3 install -U west
mkdir IFX_Zephyr && cd IFX_Zephyr
west init -m https://github.com/ifyall/zephyr.git
west update
west zephyr-export
pip3 install -r zephyr/scripts/requirements.txt

cd ..
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.2/zephyr-sdk-0.15.2_linux-x86_64.tar.gz
wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.2/sha256.sum | shasum --check --ignore-missing
tar xvf zephyr-sdk-0.15.2_linux-x86_64.tar.gz
cd zephyr-sdk-0.15.2
./setup.sh -t all -h -c
cd ../IFX_Zephyr

curl --fail "https://raw.githubusercontent.com/cy-srds/zephyr-example-capsense-buttons-slider/capsense-port-v1/CAPSENSE.yaml" -o zephyr/submanifests/CAPSENSE.yaml
west update

west build -p always -b cy8cproto_062_4343w zephyr_example_capsense_buttons_slider
sed -i "s,CONFIG_DEBUG_OPTIMIZATIONS,CONFIG_SIZE_OPTIMIZATIONS,g" zephyr_example_capsense_buttons_slider/prj.conf
west build -p always -b cy8cproto_062_4343w zephyr_example_capsense_buttons_slider
