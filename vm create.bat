cd C:\Program Files\Oracle\VirtualBox

VBoxManage controlvm "SMB-TEST" poweroff
VBoxManage unregistervm SMB-TEST --delete

VBoxManage createvm --name SMB-TEST --register

VBoxManage modifyvm SMB-TEST --ostype Ubuntu_64

echo Setting boot order
VBoxManage modifyvm SMB-TEST --boot1 disk
VBoxManage modifyvm SMB-TEST --boot2 dvddrive
VBoxManage modifyvm SMB-TEST --boot3 none
VBoxManage modifyvm SMB-TEST --boot4 none

echo enabling usb...
VBoxManage modifyvm SMB-TEST  --usb on --usbehci on
echo Enabling clipboard...
VBoxManage modifyvm SMB-TEST --clipboard bidirectional --draganddrop hosttoguest

VBoxManage createmedium --filename C:\VMs\SMB-TEST\SMB-TEST_OS.vhd --size 81920

VBoxManage modifyvm SMB-TEST --memory 4096 --vram 128

VBoxManage storagectl SMB-TEST --name "SATA Controller" --add sata --controller IntelAHCI

VBoxManage storageattach SMB-TEST --storagectl "SATA Controller" --port 0  --device 0 --type hdd --medium C:\VMs\SMB-TEST\SMB-TEST_OS.vhd

VBoxManage storageattach SMB-TEST --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium C:\ISO\ubuntu-18.10-desktop-amd64.iso
VBoxManage modifyvm SMB-TEST --nic1 bridged --bridgeadapter1 Qualcomm 

echo All Done...

VBoxManage startvm "SMB-TEST"