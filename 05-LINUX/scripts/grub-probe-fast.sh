#!/bin/bash
# Fast grub-probe wrapper for USB Arch install.
# grub-probe --target=fs_uuid on /dev/sda2 takes ~6 minutes (USB latency bug).
# This wrapper returns cached known values instantly for all queries on this device/partition.
#
# Install:
#   sudo mv /usr/bin/grub-probe /usr/bin/grub-probe.real
#   sudo cp grub-probe-fast.sh /usr/bin/grub-probe && sudo chmod +x /usr/bin/grub-probe
#
# After grub package upgrades, re-run the install commands above.

REAL=/usr/bin/grub-probe.real
KNOWN_DEV=/dev/sda2
KNOWN_UUID="dfd63dba-450d-4b77-b954-fdf760608240"
KNOWN_PARTUUID="e82c8783-8dae-4ef7-87bf-9f408007de13"

target="" device="" path=""
args=("$@")
for ((i=0; i<${#args[@]}; i++)); do
    case "${args[$i]}" in
        --target=*)  target="${args[$i]#--target=}" ;;
        --target)    target="${args[$((++i))]}" ;;
        --device=*)  device="${args[$i]#--device=}" ;;
        --device)    device="${args[$((++i))]}" ;;
        /*)          path="${args[$i]}" ;;
    esac
done

# Device-based fast-paths
if [[ "$device" == "$KNOWN_DEV" ]]; then
    case "$target" in
        fs_uuid)            echo "$KNOWN_UUID";    exit 0 ;;
        partuuid)           echo "$KNOWN_PARTUUID"; exit 0 ;;
        fs)                 echo "ext2";           exit 0 ;;
        abstraction)        echo "";               exit 0 ;;
        disk)               echo "/dev/sda";       exit 0 ;;
        partmap)            echo "gpt";            exit 0 ;;
        compatibility_hint) echo "hd0,gpt2";       exit 0 ;;
        drive)              echo "hd0";            exit 0 ;;
        hints_string)       echo "--hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2"; exit 0 ;;
        cryptodisk_uuid)    echo "";               exit 0 ;;
    esac
fi

# Path-based fast-paths — everything lives on /dev/sda2
if [[ -n "$path" ]]; then
    case "$target" in
        device)             echo "$KNOWN_DEV";  exit 0 ;;
        fs_uuid)            echo "$KNOWN_UUID"; exit 0 ;;
        fs)                 echo "ext2";        exit 0 ;;
        hints_string)       echo "--hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2"; exit 0 ;;
        compatibility_hint) echo "hd0,gpt2";    exit 0 ;;
        drive)              echo "hd0";         exit 0 ;;
        partmap)            echo "gpt";         exit 0 ;;
    esac
fi

exec "$REAL" "$@"
