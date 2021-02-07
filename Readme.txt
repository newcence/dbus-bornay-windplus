This driver allows communication between the Bornay Wind+ and Victron GX devices using Modbus. 

Cable used is USB from Wind+ to GX.

Tested on CCGX using 2.60 firmware and a Raspberry Pi 3B using 2.6 firmware.

************ Installation ******************

Assuming SSH access to the GX device, first ensure that the driver is present in /opt/victronenergy/dbus-bornay-windplus and that the file dbus-bornay-windplus.py is the current version 2.0.0

Add the necessary code to load the driver at startup.

1 - in /etc/venus/serial-starter.conf
add  
service bornay		dbus-bornay-windplus

2 - check the id of your serial cable using command - 
udevadm info --query=property --name="/dev/ttyUSB0" | sed -n "s/^ID_MODEL=//p"
You may need to check several ports (ttyUSB0, ttyUSB1 etc depending on what is connected)

in /etc/udev/rules.d/serial-starter.rules
add
add line   ACTION=="add", ENV{ID_BUS}=="usb", ENV{ID_MODEL}=="Texas_Instruments_XDS100+RS232_V1.0", ENV{VE_SERVICE}="bornay", SYMLINK+="ttyW0"
Where ENV{ID_MODEL} is the value you have found for your connection.

Having done this, restart and check the log /data/log/dbus-bornay-windplus/current to see that the driver has loaded. 






