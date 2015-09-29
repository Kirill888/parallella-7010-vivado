#!/bin/sh

zip='parallella_7020_headless.xpr.zip'
url='https://github.com/parallella/parallella-hw/raw/master/fpga/vivado/releases/parallella_7020_headless.xpr.zip'

if [ -f "$zip" ] ; then
    echo "Using $zip"
    mkdir -p tmp
    (cd tmp && unzip "../${zip}")
else
    cat <<EOF
File "$zip" not present
Please download it from:
  $url
EOF
    exit 1
fi

mkdir -p ip_7020
mkdir -p ip_7010
mkdir -p constraints

echo "Copying constraints"
cp -a tmp/parallella_7020_headless_gpiose_elink2/parallella_7020_headless_gpiose_elink2.srcs/constrs_1/imports/constraints/* constraints/

echo "Copying ip repo for 7020"
cp -a tmp/parallella_7020_headless_gpiose_elink2/parallella_7020_headless_gpiose_elink2.ipdefs/* ip_7020/

echo "Copying ip repo for 7010"
cp -a tmp/parallella_7020_headless_gpiose_elink2/parallella_7020_headless_gpiose_elink2.ipdefs/* ip_7010/
cp version_7010.v ip_7010/elink-gold/version.v


echo "Done."
echo "Run ./gen_project.sh next"
