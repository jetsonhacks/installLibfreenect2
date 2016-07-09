#!/bin/sh
PATCHDIR=$PWD
cd ~/
git clone https://github.com/OpenKinect/libfreenect2.git
cd libfreenect2
cd depends; ./download_debs_trusty.sh
sudo apt-get install build-essential cmake pkg-config -y
sudo dpkg -i debs/libusb*deb
sudo apt-get install libturbojpeg libjpeg-turbo8-dev
sudo dpkg -i debs/libglfw3*deb; sudo apt-get install -f; sudo apt-get install libgl1-mesa-dri-lts-vivid -y
# Make and Install libfreenect2
cd ..
patch -p 1 -i $PATCHDIR/bgra.patch 
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2
make
make install
cd ..
sudo cp platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules
/bin/echo -e "\e[1;32mFinished.\e[0m"
