![Icon](img/icon.png)

Blue Van Clef
=

This is a "Bluetooth Explorer" app that was written in order to develop a general-purpose Core Bluetooth "Wrapper" SDK, and learn Bluetooth.

[This is the GitHub repo for this project.](https://github.com/RiftValleySoftware/BlueVanClef) It is 100% open-source, MIT-licensed code.

[This is the online documentation for this project](https://riftvalleysoftware.github.io/BlueVanClef)

USAGE
-
This app is a simple read-only "drill-down" application. It allows you to discover nearby BLE devices, using some basic filtering, and then connect to devices (as long as they advertise as connectable).

Once connected, you can explore the device's [GATT Services](https://www.bluetooth.com/specifications/gatt/services/), [GATT Characteristics](https://www.bluetooth.com/specifications/gatt/characteristics/), and [GATT Descriptors](https://www.bluetooth.com/specifications/gatt/descriptors/).

DEPENDENCIES
-
This depends upon the [RVS_BlueToth Bluetooth SDK](https://riftvalleysoftware.github.io/RVS_BlueThoth).

It also depends upon the [RVS Generic Swift Toolbox](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox), and the [RVS Peristsent Prefs Utility](https://github.com/RiftValleySoftware/RVS_PersistentPrefs).

CARTHAGE
-
The Blue Van Clef project relies on [GitHub Carthage](https://github.com/Carthage/Carthage) to resolve dependencies. This has been built into the build process. The first time the project is built, the build will take some time, as it creates the Carthage dependencies. After that, it will be fast.

In order to ensure that Carthage is updated, simply delete the "`Carthage`" directory, and the next project build will re-import from Carthage. Otherwise, the build will continue to use the version built during the last project build.
