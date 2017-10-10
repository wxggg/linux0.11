#!/bin/bash
#
# build.sh -- a shell version of build.c for the new bootsect.s & setup.s
# author: falcon <wuzhangjin@gmail.com>
# update: 2008-10-10

bootsect=$1
setup=$2
kernel=$3
IMAGE=$4

# Set the biggest sys_size (Note: Need to document this magic number?)
SYS_SIZE=$((RAMDISK_START * 1024))

# Write bootsect (512 bytes, 1 sector)
[ ! -f "$bootsect" ] && echo "Error: No bootsect binary file there" && exit -1
dd if=$bootsect bs=512 count=1 of=$IMAGE >/dev/null 2>&1

# Write setup (4 * 512bytes, 4 sectors) see SETUPLEN in boot/bootsect.s
[ ! -f "$setup" ] && echo "Error: No setup binary file there" && exit -1
dd if=$setup seek=1 bs=512 count=4 of=$IMAGE >/dev/null 2>&1

# Write kernel (< SYS_SIZE), see the hardcoded SYSSIZE in src/boot/bootsetc.s
[ ! -f "$kernel" ] && echo "Error: No kernel binary file there" && exit -1

kernel_size=`wc -c $kernel | tr -C -d [0-9]`
sys_size=$((kernel_size + 5*512))

if [ $sys_size -gt $SYS_SIZE ]; then
    echo "Note: The kernel binary is too big, Please increase RAMDISK_START (=>256, <=400)"
    echo
    echo " e.g."
    echo "     $ make distclean"
    echo "     $ make boot RAMDISK_START=300"
    echo
    exit -1
fi

dd if=$kernel seek=5 bs=512 of=$IMAGE >/dev/null 2>&1
