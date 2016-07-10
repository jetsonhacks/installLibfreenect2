# installLibfreenect2
Install libfreenect2 on a Jetson TX1 Development Kit. libfreenect2 is an open source driver for Microsoft Kinect V2.

This repository contains a convenience script to install the prerequisites for building libfreenect and then build the library.

To run the convenience script:

$ ./installLibfreenect2.sh

When installation is complete, the example app 'Protonect' will be in the ~/libfreenect2/build/bin directory.

<b>Note:</b> There is a difference between the stock libfreenect2 library and the one being installed here. This installation adds a patch to the the example "Protonect.cpp" file. The JPEG decompressor on the Jetson produces RGBA format, where as the viewer consumes BGRA format. The patch adds a simplistic algorithm to rearrange the bytes appropriately. 

If you plan to use this library in production code, your application should consider writing specialized code to do the RGBA→BGRA conversion more efficiently

<b>Note:</b> The last commit tested on the libfreenect2 library on Github was 83f88b4c09f0b00724ae65785abcd4f3eeb79f93

libfreenect2 is at: https://github.com/OpenKinect/libfreenect2


