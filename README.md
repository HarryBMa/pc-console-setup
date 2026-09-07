# pc-console-setup

Turning a small PC into a console you can live with: it sleeps, it wakes, the
controllers connect, and nobody has to see a desktop.

This is a working log, not a finished guide. Things marked **TODO** are not
written yet, and things that are written have been run on the machine.

## The machine

| | |
|---|---|
| Box | ASUS NUC 15 Pro Slim |
| OS today | CachyOS |
| OS wanted | Arch, or SteamOS bare — [why this is not settled](os.md) |
| Controllers | 4 × 8BitDo Ultimate 2C |
| USB | [VirtualHere 4-port hub](https://modularkvmip.com/product/usb-hub/), per-port power switching via `uhubctl` |
| Display | TODO |
| Storage | TODO |

## What is here

- **[hardware/](hardware/)** — the box, the hub, what is plugged into what.
- **[os.md](os.md)** — the CachyOS/Arch/SteamOS question and where it stands.
- **[controllers/](controllers/)** — 8BitDo pairing and udev rules.
- **[power/](power/)** — sleep and wake, and switching controller power off
  by power-cycling the dongle ports with `uhubctl`.
- **[software/](software/)** — what runs on top: Deck Shelves, PC GamePak.

## The problems this is solving

Each of these is a real thing that goes wrong on a PC pretending to be a
console, and each has a page above.

**Controllers that stay awake.** A 2.4 GHz controller keeps draining its own
battery while the box sleeps. The dongle ports get *power-cycled* before
suspend: the controllers lose the link and switch themselves off, and the port
comes straight back so a button press can still wake the machine. See
[power/](power/).

**A desktop appearing.** Anything that drops to a desktop, a login prompt, or
a file manager breaks the illusion and needs a keyboard to escape.

**Games on removable drives.** Handled by
[PC GamePak](https://github.com/HarryBMa/pc-gamepak) — see
[software/pc-gamepak.md](software/pc-gamepak.md).
