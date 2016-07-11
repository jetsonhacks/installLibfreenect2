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
# Mesa links libGL.so incorrectly on Arm v8 24.1 7-10-15
ARCH="$(uname -m)"
echo "Machine Architecture: " $ARCH
if [ "$ARCH" = "aarch64" ] ; then
 SAVEDIR=$PWD
 cd /usr/lib/aarch64-linux-gnu
 sudo rm libGL.so
 sudo ln -s /usr/lib/aarch64-linux-gnu/tegra/libGL.so libGL.so
 cd $SAVEDIR
fi

cd ..
if [ "$ARCH" != "aarch64" ] ; then
 # 32 bit needs a patch for RGBA to BGRA
 patch -p 1 -i $PATCHDIR/bgra.patch 
fi

mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2
make
make install
cd ..
sudo cp platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules
/bin/echo -e "\e[1;32mFinished.\e[0m"
