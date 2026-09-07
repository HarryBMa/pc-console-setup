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

TODO: confirm firmware version on each. 8BitDo ships firmware updates that
change how the dongle enumerates, which matters for the udev rules in
[../controllers/](../controllers/).

## USB hub with per-port power switching

The dongles live in a hub whose ports can be powered down individually, driven
by [`uhubctl`](https://github.com/mvp/uhubctl). That is what makes
[../power/](../power/) possible.

TODO: exact hub model, and its `uhubctl` location string. Get it with:

```bash
sudo uhubctl
```

which lists every hub it can drive, as `Current status for hub <loc>`. A hub
that does not appear does not support per-port switching and cannot be used
this way.

## Wiring

TODO: a diagram, or at least which dongle is in which port, since the udev
rules and the `uhubctl -p` port numbers both depend on it.
