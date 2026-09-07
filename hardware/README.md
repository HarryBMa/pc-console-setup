# Hardware

## ASUS NUC 15 Pro Slim

TODO: exact model, CPU, RAM, storage.

```bash
# Fill this in from the machine:
inxi -Fxz          # or
sudo dmidecode -t system -t processor -t memory | head -40
```

## Controllers

4 × **8BitDo Ultimate 2C**. Each ships a 2.4 GHz USB dongle; that is the
connection used here rather than Bluetooth, because pairing is instant and it
survives a reboot without re-pairing.

They also switch themselves off when the dongle link drops, which is what
[../power/](../power/) exploits to put them to sleep with the box.

TODO: confirm firmware version on each. 8BitDo ships firmware updates that
change how the dongle enumerates, which matters for the udev rules in
[../controllers/](../controllers/).

## USB hub with per-port power switching

[VirtualHere 4-port USB 3 hub](https://modularkvmip.com/product/usb-hub/), USD
$39. Four ports, four controllers.

> Supports individual Per-Port-Power-Switching (PPPS). Each port can be turned
> on/off via software using VirtualHere and/or uhubctl

PPPS is the whole reason for this hub rather than any other, and it is what
makes [../power/](../power/) possible. Same company as the USB-over-IP
software, but this is the hardware — nothing here is sharing USB over a
network.

TODO: the `uhubctl` location string for this hub on this machine. Get it with:

```bash
sudo uhubctl
```

which lists every hub it can drive, as `Current status for hub <loc>`.

## Wiring

TODO: a diagram, or at least which dongle is in which port, since the udev
rules and the `uhubctl -p` port numbers both depend on it.
