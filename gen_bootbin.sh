#!/bin/sh


if hash bootgen 2> /dev/null ; then
    echo ''
else
    cat <<EOF
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! No Vivado installation found
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Please source appropriate 'settings' shell file for your installation

  Example:
     source /opt/Xilinx/Vivado/2014.3.1/settings64.sh

  Sourced it already? Then maybe you didn't install SDK, make
  sure to install SDK, it includes bootgen utility we need.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
EOF

    exit 1
fi

bootgen -w -image 7010.bif -split bin
mv elink2_top_wrapper.bit.bin parallella.bit.bin
rm 7010.bin

echo "Generated parallella.bit.bin"
echo " Now copy it to SD card and boot your board"
