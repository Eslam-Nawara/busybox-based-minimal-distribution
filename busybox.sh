#!/bin/bash

mkdir -p src
pushd src

    echo '-- downloading linux kernel --'
    wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.132.tar.xz

    echo '-- extracting linux kernal --'
    tar -xf linux-5.15.132.tar.xz

    echo  '-- compiling the kernel --'
    pushd linux-5.15.132
        make defconfig
        make -j8 || exit
    popd 

    echo '-- downloading busybox --' 
    wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2

    echo '-- extracting busybox --'
    tar -xf busybox-1.36.1.tar.bz2
    
    echo '-- building busybox in static mode --'
    pushd busybox-1.36.1
        make defconfig
        echo 'CONFIG_STATIC=y' >> .config
        make -j8 || exit
    popd 
popd

cp src/linux-5.15.132/arch/x86_64/boot/bzImage ./

mkdir -p initrd 
pushd initrd || exit
    mkdir -p bin dev proc sys
    ./../src/busybox-1.36.1/busybox --install bin

    echo '#!/bin/sh' > init
    echo 'mount -t sysfs sysfs /sys' >> init
    echo 'mount -t proc proc /proc ' >> init
    echo 'mount -t devtmpfs udev /dev ' >> init
    echo 'sysctl -w kernel.printk="2 4 1 7"' >> init
    echo 'clear' >> init
    echo '/bin/sh' >> init

    chmod -R 777 .

    find . | cpio -o -H newc > ../initrd.img
popd

qemu-system-x86_64 -kernel bzImage -initrd initrd.img 
