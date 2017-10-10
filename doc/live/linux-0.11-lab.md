
# ** Learning Linux 0.11 in Linux 0.11 Lab **

- Author: Wu Zhangjin / Falcon
- Time  : 2017/09/16 14:00 ~ 15:00
- Doc   :
    + <https://github.com/tinyclub/linux-0.11-lab>
    + <http://tinylab.org/linux-0.11-lab>
    + <http://showdesk.io/50bc346f53a19b4d1f813b428b0b7b49>
    + <http://showterm.io/ffb67385a07fd3fcec182>
    + <http://showterm.io/4b628301d2d45936a7f8a>
    + <http://tinylab.cloud:6080>
    + <http://oldlinux.org>
    + README.md

## Introduction

1. Linux 0.11 Lab
    - Docker, one image everywhere
    - Runnable on Qemu and Bochs
    - Prebuilt ramfs, floppy and harddisk images
    - Work with latest gcc
    - Function calling tree support
    - Online available: noVNC(webVNC) and Gateone(webssh)

2. Linux 0.11
    - <http://oldlinux.org>
    - <http://oldlinux.org/Linux.old/>
    - <http://www.oldlinux.org/download/clk011c-3.0.pdf>

## Quick Start

1. Compiling
    - `make`

2. Booting
    - `make boot`

3. Booting with rootfs from ram, floppy or harddisk
    - `make boot`
    - `make boot-fd`
    - `make boot-hd`

4. Booting on Qemu or Bochs
    - `make boot VM=qemu`
    - `make boot VM=bochs`
    - `make switch`: switch between Qemu and Bochs

## Debugging

Host:

    $ make debug

GDB:

    $ b main
    $ b fork
    $ s

## Transfering files between Host and Guest

### From Host to Guest

Host:

    $ cd examples/
    $ <adding new files here>
    $ make hd-install

Guest:

    $ cd /usr/root/
    $ ls examples/

### From Guest to Host

Guest:

    $ cd /usr/root/
    $ <adding new files here>

Host:

    $ make hd-mount
    $ sudo ls rootfs/_hda/usr/root/
    $ make hd-umount

## Adding a new syscall

Host:

    $ patch -p1 < examples/syscall/syscall.patch
    $ make
    $ make boot-hd

Guest:

    $ cd examples/syscall
    $ make
    Hello, Linux 0.11

## Generating function calling tree

    $ make cg func=main
    $ ls callgraph/main.__init_main_c.svg

## Booting both of Image and Rootfs from harddisk

### Compile Linux 0.11 in Guest

Host:

    $ make boot-hd

Guest:

    $ cd examples/linux-0.11/
    $ make
    $ cat /etc/config | grep ^boot
    boot /usr/root/examples/linux-0.11/Image

### Boot everything from harddisk

Host:

    $ make hd-boot
