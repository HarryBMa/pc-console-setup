# PC GamePak

<https://github.com/HarryBMa/pc-gamepak> — turns a removable drive into a game
cartridge. Plug one in and a launcher opens with the cover art and two buttons,
Play and Eject. Nothing on the drive runs by itself.

Relevant here because a console you can hand a cartridge to is the point of
this box, and because it needs no desktop: the launcher opens on insert and
closes on eject.

## Install

The Flatpak is the right answer on a SteamOS-shaped system — no root, no udev
rule, survives an immutable root.

```bash
flatpak remote-add --user --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.gnome.Platform//49 org.gnome.Sdk//49 \
    org.freedesktop.Sdk.Extension.rust-stable//25.08

git clone https://github.com/HarryBMa/pc-gamepak.git
cd pc-gamepak/packaging/flatpak
flatpak-builder --user --force-clean --install build \
    io.github.HarryBMa.PCGamePak.yml
```

There is no store listing; it is built from source. On an Arch/CachyOS system
the rootless installer (`linux/install-user.sh`) is simpler and does the same
job. Both are documented in
[INSTALL.md](https://github.com/HarryBMa/pc-gamepak/blob/main/docs/INSTALL.md).

## What it needs from this box

- **A desktop that automounts removable drives.** The watcher waits on the
  mount table, so a drive nobody mounts is a drive it never sees. `udiskie` if
  the session does not do it.
- **The watcher running at login.** Outside a sandbox that is a systemd user
  unit; inside a Flatpak it asks the Background portal.

## A cartridge

One text file at the root of any exFAT drive:

```ini
executable=steam://rungameid/413150
title=Stardew Valley
cover=cover.jpg
```

Games can live on the cartridge or be a link to one already installed. The
wizard (`pc-gamepak --create`) writes them, copies the files if asked, fetches
artwork, and registers the drive as a Steam library so copied games run from
the cartridge rather than being downloaded again.

## Skins

The launcher's look comes from the cartridge: a `.gamepak/skin.css` on the
drive restyles it — window size, layout, which artwork goes where. Fifteen
worked examples with screenshots in
[docs/skins/](https://github.com/HarryBMa/pc-gamepak/tree/main/docs/skins).

TODO: pick one for this setup. `bigpicture` is the couch-facing one.

## TODO

- [ ] Decide Flatpak or rootless install on this box, once [../os.md](../os.md)
      is settled.
- [ ] Confirm the launcher behaves in the gamescope session, not just on a
      desktop.
- [ ] Controller navigation end to end: the launcher takes a pad, but that has
      not been tested here with the Ultimate 2C dongles.
