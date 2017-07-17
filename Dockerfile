FROM agustinhenze/zephyr-docker-core

RUN apt-get update && eatmydata apt-get install wget --no-install-recommends -y && rm -rf /var/lib/apt

RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2 \
 && tar xvf gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2 \
 && rm -f gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2 \
 && mkdir /opt/toolchain \
 && mv gcc-arm-none-eabi-6-2017-q1-update /opt/toolchain/arm-none-eabi

RUN wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9572/issm-toolchain-linux-2017-02-07.tar.gz \
 && tar xvf issm-toolchain-linux-2017-02-07.tar.gz \
 && rm issm-toolchain-linux-2017-02-07.tar.gz \
 && mv issm-toolchain-linux-2017-02-07 /opt/toolchain/issm

RUN wget https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2016.09-release/arc_gnu_2016.09_prebuilt_elf32_le_linux_install.tar.gz \
 && tar xvf arc_gnu_2016.09_prebuilt_elf32_le_linux_install.tar.gz \
 && rm arc_gnu_2016.09_prebuilt_elf32_le_linux_install.tar.gz \
 && mv arc_gnu_2016.09_prebuilt_elf32_le_linux_install /opt/toolchain/arc-elf32

RUN VERSION=0.9.1-rc1 VERSION1=0.9.1-rc wget --quiet  https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/${VERSION}/zephyr-sdk-${VERSION1}-setup.run \
 && chmod +x zephyr-sdk-${VERSION1}-setup.run \
 && ./zephyr-sdk-${VERSION1}-setup.run --quiet -- -d /opt/sdk/zephyr-sdk-0.9.1 \
 && rm zephyr-sdk-${VERSION1}-setup.run

RUN useradd -m -G plugdev buildslave \
 && echo 'buildslave ALL = NOPASSWD: ALL' > /etc/sudoers.d/buildslave \
 && chmod 0440 /etc/sudoers.d/buildslave
