setenv start_mmc_autoscript 'if fatload mmc 0:1 0x1000000 s905_autoscript; then autoscr 0x1000000; fi'
setenv start_usb_autoscript 'for usbdev in 0 1 2 3; do if fatload usb ${usbdev}:1 0x1000000 s905_autoscript; then autoscr 0x1000000; fi; done'
setenv start_emmc_autoscript 'if fatload mmc 1:1 0x1000000 emmc_autoscript; then autoscr 0x1000000; fi'
setenv start_autoscript 'if mmcinfo; then run start_mmc_autoscript; fi; if usb start; then run start_usb_autoscript; fi; run start_emmc_autoscript'
run start_autoscript
