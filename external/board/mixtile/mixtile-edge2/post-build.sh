#!/bin/sh

BOARD_DIR="$(dirname $0)"

install -m 0644 -D $BOARD_DIR/brcm_firmware/ap6275s/BCM4362A2.hcd  $TARGET_DIR/lib/firmware/brcm/BCM4362A2.hcd
install -m 0644 -D $BOARD_DIR/brcm_firmware/ap6275s/clm_bcm43752a2_ag.blob $TARGET_DIR/lib/firmware/brcm/brcmfmac43752-sdio.focalcrest,mixtile-edge2.clm_blob
install -m 0644 -D $BOARD_DIR/brcm_firmware/ap6275s/fw_bcm43752a2_ag_apsta.bin $TARGET_DIR/lib/firmware/brcm/brcmfmac43752-sdio.focalcrest,mixtile-edge2.bin
install -m 0644 -D $BOARD_DIR/brcm_firmware/ap6275s/nvram_ap6275s.txt $TARGET_DIR/lib/firmware/brcm/brcmfmac43752-sdio.focalcrest,mixtile-edge2.txt


