Introduction
----------------------

Parallella board is an "18-core credit card sized computer". Read more
about it [here](http://www.parallella.org/board/). The board has a
16-core Epiphany processor and a 2-core Zynq-7000 CPU+FPGA combo. The
two are connected via FPGA fabric. FPGA code needed for that
interconnect is developed in the open
[https://github.com/parallella/parallella-hw/](https://github.com/parallella/parallella-hw/)

Alas, FPGA development is hard. Building from source is not as simple
as `./confugure; make` you might be used to. So Adapteva released a
[Vivado](http://www.xilinx.com/products/design-tools/vivado.html)
based project:

[https://www.parallella.org/2015/03/23/new-parallella-elink-fpga-design-project-now-available-in-vivado/](https://www.parallella.org/2015/03/23/new-parallella-elink-fpga-design-project-now-available-in-vivado/)

Read blog post above to appreciate the complexity of the build
process. To complicate things more, there are several parallella board
configurations: two are based on Zynq-7010 and one is based on
Zynq-7020. Vivado project above is for 7020, but I have 7010 ...

This repository contains a bunch of scripts that create Vivado project
for 7010 version of the board.

Target Audience
-----------------

1. You have parallella board "desktop edition"
2. You want to "do some custom fpga work on it"

If you just want to play around with Epiphany chip, please, use
pre-compiled sd-card images supplied by Adapteva. No need to go in to
all this trouble.

Build Instructions
---------------------

1. Download released Vivado project for 7020 headless into this folder [from github](https://github.com/parallella/parallella-hw/raw/master/fpga/vivado/releases/parallella_7020_headless.xpr.zip) 
2. Run `./prepare.sh`
3. Run `./gen_project.sh`
4. Open generated project in Vivado and build bitstream
5. Run `./gen_bootbin.sh`

Note that Vivado tools need to be on your `PATH` when running scripts
above (except for `prepare.sh`). Also note that you must install
2014.3.1 version of Vivado, unless you know what you are doing and can
upgrade IPs and possibly make fixes if any of them change enough. Also
make sure to tick SDK option during installation, you'll need it for
`bootgen` utility.

I developed on Ubuntu 14.04 64-bit setup with Vivado tools 2014.3.1. I
have tested generated bitstream on my "desktop" parallella board, and
it booted successfully and I ran some Epiphany test apps, they seem to
work as expected. I didn't do any comprehensive tests of the eLink
implementation.


Conversion Approach Used
-------------------------

1. Convert original project to tcl following instructions here:
[http://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html](http://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html)
2. Verify generated project still works for 7020 (by works I mean "can generate bitstream")
3. Update tcl code to setup 7010 based system instead
4. Update block design to remove GPIO pins that are 7020 specific
5. Remove 7020 specific GPIO constraints file from the project
6. Update version.v to specify 7010 as desired target

I also removed "update logs" from the project before converting it to
tcl, I don't think they matter, and some of them were missing from the
distribution anyway. Also I skipped "test_bench" block design.
