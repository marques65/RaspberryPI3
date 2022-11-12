#!/bin/sh

DIR_ZIMAGE=arch/arm/boot/zImage
DIR_DEVICETREE=arch/arm/boot/dts/bcm2837-rpi-3-b.dtb

PLATAFORM=arm
BOARD_DEFCONFIG=multi_v7_defconfig
CROSS_COMPILE=arm-linux

cd $(pwd)/linux/

#config linux kernel to raspberry pi 3 b 
make ARCH=${PLATAFORM} CROSS_COMPILE=${CROSS_COMPILE}- ${BOARD_DEFCONFIG}
echo "********** Starting Linux kernel Compilation **********"

#Build linux kernel $ make ARCH=arm CROSS_COMPILE=arm-linux- zImage -j4 
make ARCH=${PLATAFORM} CROSS_COMPILE=${CROSS_COMPILE}- zImage -j4

if [ -f ${DIR_ZIMAGE} ]
then 
	echo "Successful compilation of zImage"
else
	echo "error in compiling zImage"
fi

#Build device tree to raspberry pi 3 b make ARCH=arm CROSS_COMPILE=arm-linux- imx6dl-colibri-aster.dtb
echo "********** Starting Device Tree Compilation **********"
make ARCH=${PLATAFORM} CROSS_COMPILE=${CROSS_COMPILE}- bcm2837-rpi-3-b.dtb

if [ -f ${DIR_DEVICETREE} ]
then 
	echo "Successful compilation of Device Tree ... Done"
else 
	echo "Error in compiling Device Tree ... Done"
fi

echo "********** Checking existence of Directories **********"
if [ -d "$(pwd)/Kernel_files/" ]
then
	echo "Directory found ... Done"
else
	echo "Directory not found"
	echo "Creating directory ... Done"
	sudo mkdir $(pwd)/Kernel_files/
	
fi
echo "********** Copying necessary files to: $(pwd)/Kernel_files **********"
sudo cp  ${DIR_ZIMAGE} $(pwd)/Kernel_files/
sudo cp  ${DIR_DEVICETREE} $(pwd)/Kernel_files/

echo "********** Done **********"

cd ..