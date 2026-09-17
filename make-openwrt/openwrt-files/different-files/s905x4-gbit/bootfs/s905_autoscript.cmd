echo "start S905X4 OpenWrt"
setenv kernel_addr_r 0x11000000
setenv fdt_addr_r 0x1000000
setenv loadaddr 0x1080000
setenv l_mmc "0"
for devtype in "mmc usb" ; do if test "${devtype}" = "usb"; then setenv l_mmc "0 1 2 3"; fi; for devnum in ${l_mmc} ; do if test -e ${devtype} ${devnum}:1 uEnv.txt; then fatload ${devtype} ${devnum}:1 ${loadaddr} uEnv.txt; env import -t ${loadaddr} ${filesize}; setenv bootargs ${APPEND}; if fatload ${devtype} ${devnum}:1 ${kernel_addr_r} ${LINUX}; then if fatload ${devtype} ${devnum}:1 ${fdt_addr_r} ${FDT}; then fdt addr ${fdt_addr_r}; booti ${kernel_addr_r} - ${fdt_addr_r}; fi; fi; fi; done; done;
echo "OpenWrt: boot failed"
