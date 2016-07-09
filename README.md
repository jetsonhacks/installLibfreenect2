# installLibfreenect2
Install libfreenect2 on a Jetson Development Kit. libfreenect2 is an open source driver for Microsoft Kinect V2.

This repository constains a convenience script to install the prerequisites for building libfreenect and building the library.

<b>Note:</b> There is a difference between the stock libfreenect2 library and the one being installed here. This installation adds a patch to the the example "Protonect.cpp" file. The JPEG decompressor on the Jetson produces RGBA format, where as the viewer consumes BGRA format. The patch adds a simplistic algorithm to rearrange the bytes appropriately. 

If you plan to use this library in production code, your application should consider writing specialized code to do the RGBA→BGRA conversion more efficiently.
