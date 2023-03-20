#!/bin/bash


# Run:
# chmod +x platformio-cli-ubuntu-support.sh
# sudo ./platformio-cli-ubuntu-support.sh

yes | sudo apt autoremove brltty && \
# or,
# sudo apt purge --auto-remove brltty && \

yes | sudo apt update && \
# https://www.pragmaticlinux.com/2021/11/how-to-monitor-the-serial-port-in-linux/
sudo apt install -y cutecom && \
# https://askubuntu.com/questions/786367/setting-up-arduino-uno-ide-on-ubuntu
# https://askubuntu.com/questions/781571/how-to-identify-devices-connected-to-serial-port
# https://unix.stackexchange.com/questions/390184/dmesg-read-kernel-buffer-failed-permission-denied
# https://0xsuk.github.io/posts/2022-07-19-how-to-install-ch340-on-ubuntu-22.04/
sudo apt install -y hwinfo && \
sudo apt install -y setserial && \
pip install esptool && \
sudo usermod -a -G plugdev $USER  && \
sudo usermod -a -G dialout $USER && \
# https://docs.platformio.org/en/latest/core/userguide/device/cmd_monitor.html#cmd-device-monitor
# https://docs.platformio.org/en/latest/core/installation/udev-rules.html
curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules  && \
sudo service udev restart && \
sudo udevadm control --reload-rules && \
sudo udevadm trigger && \
sudo usermod -a -G dialout $USER && \
sudo usermod -a -G plugdev $USER && \
# sudo reboot
sudo chmod a+rw /dev/ttyUSB0 && \
sudo chmod a+rw /dev/ttyS0 && \
setserial -g /dev/ttyS0 && \
setserial -g /dev/ttyS[0123] && \
sudo sysctl kernel.dmesg_restrict=0 && \
# sudo reboot
echo "ls -l /dev/ttyUSB* /dev/ttyACM* ..." && \
ls -l /dev/ttyUSB* /dev/ttyACM* && \
# ls -l /dev/ttyUSB* /dev/ttyACM*
# ls: cannot access '/dev/ttyACM*': No such file or directory
# crw-rw-rw- 1 root dialout 188, 0 Mar 20 01:08  /dev/ttyUSB0
# hwinfo --short
#
#                        Serial controller
#   /dev/ttyUSB0         QinHeng Electronics HL-340 USB-Serial adapter
echo "dmesg | egrep --color 'serial|ttyS' ..." && \
dmesg | egrep --color 'serial|ttyS' && \
echo "dmesg | grep tty ..." && \
dmesg | grep tty && \
echo "dmesg | tail -f ..." && \
dmesg | tail -f && \
echo "hwinfo --short ..." && \
hwinfo --short && \
echo "lsusb ..." && \
lsusb && \
echo "ls -l /dev/tty* ..." && \
ls -l /dev/tty* && \
echo "dmesg | grep tty ..." && \
dmesg | grep tty \
