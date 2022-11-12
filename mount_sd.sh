#!/bin/sh

#mount all files in sd card

echo "Enter the location of the first sd card partition: ";
read SD_PARTITION1

echo "Enter the location of the second sd card partition: ";
read SD_PARTITION2


sudo umount /dev/${SD_PARTITION1}
sudo umount /dev/${SD_PARTITION2}

echo "Inform the mounting location of the first partition: ";
read SD_PARTITION1_DIR

echo "Inform the mounting location of the second partition: ";
read SD_PARTITION2_DIR

sudo mount /dev/${SD_PARTITION1} ${SD_PARTITION1_DIR}
sudo mount /dev/${SD_PARTITION2} ${SD_PARTITION2_DIR}

#Copy files u-boot to sd card 
sudo cp -r $(pwd)/u-boot/bootloader/* ${SD_PARTITION1_DIR}
#Copy files linux kernel to sd card 
sudo cp -r $(pwd)/linux/Kernel_files/* ${SD_PARTITION1_DIR}
#Copy files source raspberry pi to sd card
sudo cp -r $(pwd)/raspberryboot/* ${SD_PARTITION1_DIR}

#Install busybox into sd card
cd ${PWD}/busybox/
echo "\n********** Install root file system in sd card **********"
sudo make CONFIG_PREFIX=${SD_PARTITION2_DIR} install

echo "\n********** Complete instalation please wait **********"
#Checking the existence of directories
cd ..
if [ -d "${SD_PARTITION2_DIR}/dev/" ]
then
	echo "Directory /dev found"
else
	echo "Directory /dev not found"
	echo "Creating directory ..."
	sudo cp -r $(pwd)/add_directory/add_busybox/dev ${SD_PARTITION2_DIR}
	echo "DONE"
fi

if [ -d "${SD_PARTITION2_DIR}/proc/" ]
then
	echo "Directory /proc found"
else
	echo "Directory /proc not found"
	echo "Creating directory ..."
	sudo cp -r $(pwd)/add_directory/add_busybox/proc ${SD_PARTITION2_DIR}
	echo "DONE"
fi

if [ -d "${SD_PARTITION2_DIR}/sys/" ]
then
	echo "Directory /sys found"
else
	echo "Directory /sys not found"
	echo "Creating directory ..."
	sudo cp -r $(pwd)/add_directory/add_busybox/sys ${SD_PARTITION2_DIR}
	echo "DONE"
fi

if [ -d "${SD_PARTITION2_DIR}/etc/" ]
then
	echo "Directory /etc found"
else
	echo "Directory /etc not found"
	echo "Creating directory ..."
	sudo cp -r $(pwd)/add_directory/add_busybox/etc ${SD_PARTITION2_DIR}
	echo "DONE"
fi


if [ -d "${SD_PARTITION2_DIR}/lib/" ]
then
	echo "Directory /lib found"
else
	echo "Directory /lib not found"
	echo "Creating directory ..."
	sudo cp -r $(pwd)/add_directory/add_busybox/lib ${SD_PARTITION2_DIR}
	echo "DONE"
fi

sync  
sudo umount ${SD_PARTITION1_DIR}
sudo umount ${SD_PARTITION2_DIR}

echo "****************************************************************"
echo "*                                                              *"
echo "*                    Complete installation                     *"
echo "*                                                              *"
echo "****************************************************************"

cd ..