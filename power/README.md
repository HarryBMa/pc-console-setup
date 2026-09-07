# Power: sleep, wake, and controller dongles

## The problem

Two things pulling in opposite directions.

A 2.4 GHz controller left connected keeps its own battery draining while the box
is asleep. But the dongle is also the only thing that can wake the box when
somebody picks up a controller — and a console you cannot wake from the sofa is
not a console.

Cutting power to the port solves the first and breaks the second.

## What works: cycle, not off

`uhubctl -a cycle` drops the port and brings it straight back.

The controllers see the link disappear and **switch themselves off** — that is
the battery saving. The port then comes back up, so the dongle is live again
before the machine finishes suspending, and **a button press still wakes the
box**.

Off would have saved the same battery and cost the wake. Cycle gets both, and
there is nothing to undo on resume because nothing was left off.

## The hub

[VirtualHere 4-port USB 3 hub](https://modularkvmip.com/product/usb-hub/) —
USD $39, aluminium case, four ports for four controllers.

> Supports individual Per-Port-Power-Switching (PPPS). Each port can be turned
> on/off via software using VirtualHere and/or uhubctl

PPPS is the part that matters and most hubs do not have it. Check any hub before
buying it:

```bash
sudo pacman -S uhubctl
sudo uhubctl
```

Every hub it can drive is listed as `Current status for hub <loc>`. A hub that
does not appear cannot do any of this.

## uhubctl

Note the location string and the port numbers, then:

```bash
sudo uhubctl -l <loc> -p 1,2,3,4 -a cycle       # drop and restore
sudo uhubctl -l <loc> -p 1,2,3,4 -a cycle -d 3  # longer dark period
sudo uhubctl -l <loc> -p 1,2,3,4 -a off         # dead until switched back on
```

## Doing it around sleep

[`uhubctl-sleep`](uhubctl-sleep) is a `systemd-sleep` hook: cycle on `pre`,
nothing on `post`.

```bash
sudo install -Dm755 uhubctl-sleep /usr/lib/systemd/system-sleep/uhubctl-sleep
```

**It does nothing until `HUB` and `PORTS` are set inside it.** There is no
sensible default, and guessing would cycle the wrong port.

systemd waits for a `pre` hook to return before suspending, so the cycle
finishes first.

Check it ran:

```bash
journalctl -t uhubctl-sleep -n 20
```

**TODO:** this repo carries the sleep-hook form. The running setup drives the
same `uhubctl -a cycle` from a udev script — add that here and drop whichever
of the two turns out to be redundant.

## Open questions

- [ ] Does the NUC 15 allow the dongle as a wake source at all?
      `cat /sys/bus/usb/devices/<dev>/power/wakeup` should say `enabled`.
- [ ] Do the controllers reconnect on their own after the cycle, or is the
      first button press swallowed waking them?
- [ ] Does the hook survive an immutable root on bare SteamOS?
      See [../os.md](../os.md).
