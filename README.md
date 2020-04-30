![Icon](img/icon.png)

BlueVanClef
=

This is a "Bluetooth Explorer" app that was written in order to develop a general-purpose Core Bluetooth "Wrapper" SDK, and learn Bluetooth.

[This is the GitHub repo for this project.](https://github.com/RiftValleySoftware/BlueVanClef) It is 100% open-source, MIT-licensed code.

Although this is an iOS app, it will be used to develop a cross-[Apple]-platform SDK.

[This is the online documentation for this project](https://riftvalleysoftware.github.io/BlueVanClef)

DEPENDENCIES
-
This depends upon the [RVS_BlueToth SDK](https://riftvalleysoftware.github.io/RVS_BlueToth)

USAGE
-
This app is a simple read-only "drill-down" application. It allows you to discover nearby BLE devices, using some basic filtering, and then connect to devices (as long as they advertise as connectable).

Once connected, you can explore the device's [GATT Services](https://www.bluetooth.com/specifications/gatt/services/), [GATT Characteristics](https://www.bluetooth.com/specifications/gatt/characteristics/), and [GATT Descriptors](https://www.bluetooth.com/specifications/gatt/descriptors/).

READ-ONLY
-
Version 1.0 of the app is a "read-only" explorer. It does not allow Charateristics or Descriptors to be modified.