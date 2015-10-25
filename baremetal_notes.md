Introduction
--------------------------

This document is incomplete, for now I'm just dumping notes about
compiling/running baremetal apps on parallella.


SDK Gotchas
-------------------------

Default auto-generated inker script is wrong, need to edit it such that all sections point to ddr.


To convert elf to binary
-------------------------

    arm-xilinx-eabi-objcopy -O binary my_mult.elf my_mult.bin



In u-boot
---------------------------

This is a script we will run

    echo Configuring PL
    mmc rescan
    mmcinfo
    fatload mmc 0 0x4000000 ${bitstream_image}
    fpga load 0 0x4000000 0x3dbafc
    fatload mmc 0 0x100000 my_mult.bin
    go 0x100000


We will setup environement variable with that script, save it to qspi,
then use it when testing baremetal app. Without sd-card plugged in and
with serial port connected to your computer boot up parallella board,
you will boot to u-boot prompt. Run these commands:

    set my_boot 'echo Configuring PL; mmc rescan; mmcinfo; fatload mmc 0 0x4000000 ${bitstream_image}; fpga load 0 0x4000000 0x3dbafc; fatload mmc 0 0x100000 my_mult.bin; go 0x100000'
    saveenv

Now you have `my_boot` environment variable, that you can run, by typing `run my_boot`


Test procedure is:

  1. Make sure serial is connected to your computer
  2. Make sure sd card is NOT plugged in
  3. Power up the board
  4. Plug sd-card back in
  5. in u-boot> run my_boot

