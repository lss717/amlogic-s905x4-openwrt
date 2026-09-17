echo "start S905X4 OpenWrt (eMMC)"
setenv kernel_addr_r 0x11000000
setenv fdt_addr_r 0x1000000
setenv loadaddr 0x1080000
if test -e mmc 1:1 uEnv.txt; then fatload mmc 1:1 ${loadaddr} uEnv.txt; env import -t ${loadaddr} ${filesize}; setenv bootargs ${APPEND}; if fatload mmc 1:1 ${kernel_addr_r} ${LINUX}; then if fatload mmc 1:1 ${fdt_addr_r} ${FDT}; then fdt addr ${fdt_addr_r}; booti ${kernel_addr_r} - ${fdt_addr_r}; fi; fi; fi
echo "OpenWrt: boot failed"
