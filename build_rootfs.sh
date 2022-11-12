#!/bin/bash


#build root file system to raspberry pi 3 model b 
sudo apt install gcc-arm-linux-gnueabihf
#copy file .config
PWD=$(pwd)

sudo cp -av $(pwd)/.configs/busybox/.config ${PWD}/busybox/

echo "********** Copy file .config to buxybox **********"

cd ${PWD}/busybox/

#build rootfile system
make busybox -j4

if [ -f ${PWD}/busybox ]
then 
	echo "********** Successful compilation of busybox ... Done **********"
else 
	echo "********** Error in compiling busybox ... Done **********"
fi


cd ..