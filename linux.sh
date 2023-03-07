#!/bin/bash

################

#   MiniLinux Linux kernel builder

#   MIT License

#   Copyright (c) 2023 Andrea Canale

#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:

#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.

#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.

###############

# Define latest stable linux version
LINUX_VERSION=6.2.2

if [ "$1" = "" ]
then
    echo "Usage: $0 KERNEL"
    echo """
        1 Kernel stable
        2 Zen Linux
        3 Clear Linux kernel
        4 Xanmod Linux kernel
    """
fi

if [ "$1" = "1" ]
then
    wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$LINUX_VERSION.tar.xz
    tar -xvf linux-$LINUX_VERSION.tar.xz
    cd linux-$LINUX_VERSION || exit
    cp ../kernel_config/defconfig .config
    make -j$(nproc)
    rm -rf linux-$LINUX_VERSION.tar.xz
elif [ "$1" = "2" ]
then
    echo "Compiling zen kernel"
    git clone https://github.com/zen-kernel/zen-kernel.git src/linux
    cd src/linux || exit
    cp ../../kernel_config/defconfig .config
    make -j$(nproc)
elif [ "$1" = "3" ]
then
    git clone https://github.com/DistroNext/clear_linux_kernel_builder.git src/linux
    bash src/clear_linux_kernel_builder/build.sh
elif [ "$1" = "4" ]
then
    git clone https://github.com/xanmod/linux.git
    cd linux || exit
    cp ../kernel_config/xanmod .config
    make -j$(nproc)
else
    echo "Invalid choice, aborting"
    exit 255
fi