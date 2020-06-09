#!/bin/bash
#
# Written by Tobias Lensing, https://tlensing.org
# For more information see https://blog.tlensing.org/2013/02/24/objective-c-on-linux-setting-up-gnustep-clang-llvm-objective-c-2-0-blocks-runtime-gcd-on-ubuntu-12-04/
#

if [ -d "/usr/local/include/objc" ]; then
    echo ""
	echo "changed=false comment='libobjc2 already installed'"
else
	tar xvf libobjc2-1.6.1.tar.bz2
	export CC=clang
	cd libobjc2-1.6.1
	make -f Makefile install
	echo "" ## This echos an empty line and is required
	echo "changed=True comment='libobjc2 installed'"
fi


