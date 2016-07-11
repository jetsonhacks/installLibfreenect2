# installLibfreenect2
Install libfreenect2 on a Jetson TX1 Development Kit. libfreenect2 is an open source driver for Microsoft Kinect V2.

This repository contains a convenience script to install the prerequisites for building libfreenect and then build the library.

To run the convenience script:

$ ./installLibfreenect2.sh

When installation is complete, the example app 'Protonect' will be in the ~/libfreenect2/build/bin directory.

<h2>Notes</h2>

<h3>USB firmware</h3>
In the current 32 bit (L4T 23.2) and 64 bit (L4T 24.1) releases (as of July 10, 2016) there is an issue in the usb firmware which causes transfer failures with the Kinect V2. NVIDIA has made a firmware patch available. See: 

https://devtalk.nvidia.com/default/topic/919354/jetson-tx1/usb-3-transfer-failures/post/4899105/#4899105

As a convenience, that patch is available from this repository, execute:

$ ./firmwarePatch.sh

which will copy the firmware file to the correct directory.

<h3>RGBA→BGRA Patch</h3>
On L4T 23.X versions (currently L4T 23.2), there is a difference between the stock libfreenect2 library and the one being installed here. This installation needs to add a patch to the the example "Protonect.cpp" file. The JPEG decompressor on the Jetson produces RGBA format, where as the viewer consumes BGRA format. The patch adds a simplistic algorithm to rearrange the bytes appropriately. To install the patch, uncomment the patch command line in installLibfreenect2.sh

If you plan to use this library in production L4T 23.X code, your application should consider writing specialized code to do the RGBA→BGRA conversion more efficiently.

For L4T 24.1, there is no patch applied as the JPEG decompressor produces BGRA format natively.

<b>Note:</b> The last commit tested on the libfreenect2 library on Github was 83f88b4c09f0b00724ae65785abcd4f3eeb79f93

libfreenect2 is at: https://github.com/OpenKinect/libfreenect2


