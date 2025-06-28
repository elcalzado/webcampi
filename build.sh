#!/bin/sh

BR2_EXTERNAL=/home/user/webcampi make -C buildroot/ webcampi_raspberrypizero2w_64_defconfig

make -C buildroot/ all
