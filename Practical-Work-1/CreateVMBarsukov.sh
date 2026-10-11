#!/usr/bin/env bash

set -euo pipefail

VM_NAME="Linux of Barsukov"
VDI_PATH="${1:-$HOME/VirtualBox VMs/Linux-Barsukov/Linux.vdi}"

if [[ ! -f "$VDI_PATH" ]]; then
    echo "VDI image not found: $VDI_PATH" >&2
    echo "Usage: $0 /full/path/to/image.vdi" >&2
    exit 1
fi

VBoxManage createvm --name "$VM_NAME" --ostype Debian_64 --register
VBoxManage modifyvm "$VM_NAME" --cpus 1 --memory 734 --vram 128 \
    --graphicscontroller vboxvga --nic1 nat
VBoxManage storagectl "$VM_NAME" --name "BarsukovSATA" \
    --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "BarsukovSATA" \
    --port 0 --device 0 --type hdd --medium "$VDI_PATH"
VBoxManage startvm "$VM_NAME"
