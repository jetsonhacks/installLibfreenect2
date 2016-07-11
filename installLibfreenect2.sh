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
 LIBDIR=""
 if [ -d "/usr/lib/arm-linux-gnueabihf" ] ; then
  LIBDIR="/usr/lib/arm-linux-gnueabihf"
 else
  if [ -d "/usr/lib/aarch64-linux-gnu" ] ; then
    LIBDIR="/usr/lib/aarch64-linux-gnu"
  fi
 fi
echo $LIBDIR

 cd $LIBDIR
 sudo rm libGL.so
 sudo ln -s $LIBDIR/tegra/libGL.so libGL.so
 cd $SAVEDIR
fi

cd ..
 # Uncomment this patch line if using version 23.X
 # 32 bit needs a patch for RGBA to BGRA
 # patch -p 1 -i $PATCHDIR/bgra.patch 

mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2
make
make install
cd ..
sudo cp platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules
/bin/echo -e "\e[1;32mFinished.\e[0m"
