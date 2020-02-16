#!/bin/sh

# ./create vm.sh vm1 Debian 64 1024 20000 3393 Downloads/debian-7.1.0-amd64-netinst.iso
# VBoxManage startvm vm1 -type headless
# VBoxManage unregistervm vm1 --delete


VM NAME=$LFS_TEST

OS TYPE=$Ubuntu 64

MEMORY SIZE=$4096

HDD SIZE=$128

VRDEPORT=$22

DVD PATH=$/home/parker/Desktop/ubuntu-18.04.2-live-server-amd64.iso

HDD PATH="/media/parker/VM DISK/OS.vhd"



VBoxManage createvm -name LFS_TEST -ostype Ubuntu_64 --register
VBoxManage modifyvm LFS_TEST \
    --memory 4096 \
    --vram 128 \
    --pae off \
    --rtcuseutc on \
    --audio alsa --audiocontroller ac97 \
    --nic1 bridged --bridgeadapter1 en01 \
    --mouse usbtablet \
    --usb on \
    --usbehci on


VBoxManage createvdi --filename "/media/parker/VM DISK/OS.vhd"
 --size 128

VBoxManage storagectl LFS TEST --name "IDE Controller" --add ide
VBoxManage storagectl LFS TEST --name "SATA Controller" --add sata

VBoxManage storageattach LFS TEST --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /home/parker/Desktop/ubuntu-18.04.2-live-server-amd64.iso

VBoxManage storageattach LFS TEST --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "/media/parker/VM DISK/OS.vhd"



VBoxManage modifyvm LFS TEST \
    --vrde on \
    --vrdeaddress 127.0.0.1 \
    --vrdeport 22

