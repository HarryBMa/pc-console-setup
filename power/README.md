# Power: sleep, wake, and controller dongles

## The problem

A 2.4 GHz controller dongle keeps drawing power while the machine is asleep,
and on some boards it can wake the machine on its own — so the box wakes up in
the night because a controller was jostled. Cutting power to the port fixes
both.

## uhubctl

[`uhubctl`](https://github.com/mvp/uhubctl) switches power on individual USB
ports, on hubs whose hardware supports it. Most do not; check yours first:

```bash
sudo pacman -S uhubctl
sudo uhubctl
```

Every hub it can drive is listed as `Current status for hub <loc>`. If the hub
holding the dongles is not in that list, none of the rest of this works and the
hub has to be replaced.

Note the location string and the port numbers. Then:

```bash
sudo uhubctl -l <loc> -p 1,2,3,4 -a off    # off
sudo uhubctl -l <loc> -p 1,2,3,4 -a on     # on
```

## Doing it around sleep

[`uhubctl-sleep`](uhubctl-sleep) is a `systemd-sleep` hook: off before suspend,
on after resume.

```bash
sudo install -Dm755 uhubctl-sleep /usr/lib/systemd/system-sleep/uhubctl-sleep
```

**It does nothing until `HUB` and `PORTS` are set inside it.** There is no
sensible default and guessing would power off the wrong port, so it exits
quietly instead. Both values come from `sudo uhubctl` above.

Check it ran:

```bash
journalctl -t uhubctl-sleep -n 20
```

## Waking with a controller — TODO

Powering the port down means the dongle cannot wake the machine, which is the
point. But a console wakes when you press a button, and this setup does not
have an answer for that yet. Options, none tested:

- Leave one port powered and allow it as a wake source
  (`/sys/bus/usb/devices/<dev>/power/wakeup`).
- Wake on a separate device — a remote, a power button on the desk.
- Do not suspend at all; blank the display and idle instead.

## Open questions

- [ ] Does the NUC 15 respect USB wake at all? **TODO: test.**
- [ ] Does the hook survive an immutable root on bare SteamOS?
      See [../os.md](../os.md).
- [ ] Do the controllers reconnect on their own after port power returns, or
      does a button press need to be swallowed?
