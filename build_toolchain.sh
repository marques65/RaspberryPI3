#!/bin/sh 


BOARD_NAME=armv8-rpi3-linux-gnueabihf
COMPILE_NAME=arm-linux-
#build toolchain 

sudo mkdir /opt/cross_compile
sudo mkdir /opt/cross_compile/toolchain
sudo chmod -R 777 /opt/cross_compile
sudo chmod -R 777 /opt/cross_compile/toolchain

sudo chmod -R 777 $(pwd)/*

cd $(pwd)/crosstool-ng

if [ -f "bootstrap" ]
then 
	echo "running bootstrap"
	sudo ./bootstrap
else
	echo "Error, file not found"
fi 

if [ -f "configure" ]
then 
	echo "Setting"
	sudo ./configure
else
	echo "Error, file not found"
fi 

echo "Preparing to install"
sudo make 
echo "installing"
sudo make install
echo "DONE"
ct-ng  ${BOARD_NAME}

echo "Copying .config"

cp $(dirname $(pwd))/.configs/toolchain/.config $(pwd)


ct-ng build

if [ -d "/opt/cross_compile/toolchain/bin"]
then 
	echo "********** Complete compilation **********"
else 
	echo "Error, not compiled"
fi
echo "This is your version of the toolchain:"
arm-linux-gcc --version 