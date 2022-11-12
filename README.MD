SD Card Partition: 
 -> first partition boot (fat32) ≅ 150mb
 -> secound partition rootfs (ext4)

SD Card files to boot (source Raspberry pi):
 -> bootcode.bin
 -> cmdline.txt
 -> config.txt
 -> fixup.dat
 -> start.elf

Toochain: arm-linux-gnueabihf

Files boot U-boot:
 -> u-boot.bin
 -> boot.scr

Files linux kernel:
 -> bcm2837-rpi-3-b.dtb (device tree)
 -> zImage (kernel img)

Directorys rootfs:
-bin 
-dev 
-etc 
-lib
-linuxrc
-proc
-sbin 
-sys
-usr

Configure on first boot on target:
> setenv load_kernel 'fatload mmc 0:1 ${kernel_addr_r} zImage'
> setenv load_dtb 'fatload mmc 0:1 ${fdt_addr_r} bcm2837-rpi-3-b.dtb'
> setenv bootcmd 'run load_kernel; run load_dtb; bootz ${kernel_addr_r} - ${fdt_addr_r}'
> setenv bootargs '${consolecfg} root=/dev/mmcblk0p2 rootfstype=ext4 rootwait rw'
> saveenv
> boot

to clone repository: git clone --recurse-submodules https://github.com/MarquesNatan/RaspberryPi
