# Which OS

Running **CachyOS** today. The intent is **Arch, or SteamOS bare**. Not settled.

## The three options

**CachyOS** — where it is now. Arch underneath, so everything below applies,
with a tuned kernel and a working installer. Nothing here is blocked on moving
off it.

**Arch, bare** — the same thing with fewer decisions made for you. Gamescope
session and Steam come from the repos. Everything on this page assumes an
Arch-shaped system regardless of which of these two it is.

**SteamOS, bare** — Valve's image, not the Deck-specific hardware bits. The
draw is that the console behaviour is the default rather than something
assembled: the gamescope session, the Steam UI on boot, the update model.
The cost is an immutable root, so `uhubctl`, udev rules and anything else here
has to survive `steamos-readonly` and A/B updates.

## What actually decides it

- [ ] Does the NUC 15's hardware work on SteamOS's kernel — Wi-Fi, Bluetooth,
      the iGPU, sleep? **TODO: test.**
- [ ] Can the `uhubctl` sleep hook in [power/](power/) live on an immutable
      root without being undone by an update? **TODO.**
- [ ] Is Deck Shelves (Decky) supported on bare SteamOS the same way it is on
      a Deck? **TODO.**

None of these is answered yet. Until they are, staying on CachyOS costs
nothing, and everything written here is portable between the three.
