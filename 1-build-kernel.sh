#!/bin/bash

# clone linux-dev fork
# cd linux-dev; ./build_deb.sh

if [ -d ./linux-dev ] ; then
	cd linux-dev
	git checkout am33x-v3.8-ninja
	git pull
else
	git clone https://github.com/theojulienne/linux-dev.git
	cd linux-dev
	git checkout am33x-v3.8-ninja
fi

./build_deb.sh
