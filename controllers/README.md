# Controllers

4 × **8BitDo Ultimate 2C**, connected by their 2.4 GHz dongles rather than
Bluetooth: pairing is instant and survives a reboot without re-pairing.

## Modes

The Ultimate 2C has a mode switch. Which one matters:

- **X-input** — shows up as an Xbox 360 pad. Works everywhere with no rules.
- **D-input** — a generic HID gamepad. Some games map it wrongly.
- **Switch mode** — not useful here.

TODO: confirm which mode each controller is in and whether Steam Input is
handling them or the kernel is.

## udev rules

TODO — to be added.

Rules go in [udev/](udev/) and install to `/etc/udev/rules.d/`. Reload with:

```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
```

What they will likely need to do:

- Give the dongles a stable name or symlink, so the `uhubctl` port mapping in
  [../power/](../power/) does not depend on plug order.
- Set permissions if anything other than Steam needs to read them.

To find the identifiers to match on:

```bash
lsusb                                   # vendor:product
udevadm info -a -n /dev/input/eventX    # the full attribute walk
```

## Open questions

- [ ] Do all four dongles present the same vendor/product ID? If so, rules
      cannot tell them apart and the hub port is the only stable identity.
- [ ] Does controller order survive a reboot, or do players get shuffled?
