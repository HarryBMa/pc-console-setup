# Deck Shelves

<https://github.com/santojon/Deck-Shelves> — a Decky plugin that replaces the
Steam Home screen with shelves built from collections, library tabs and
filters.

TODO: the actual setup — which shelves, in what order, backed by what.

## Why it is here

The stock Steam Home screen is a recents row and not much else. This makes the
first screen of the console the one that matters.

## Requires

- [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader)
- The gamescope session — see [../os.md](../os.md), because whether this works
  on bare SteamOS the same way it does on a Deck is one of the open questions.

## Shelf ideas for this box

- [ ] TODO: fill in from the real setup.

## Cartridge shelf

A shelf that fills when a cartridge is plugged in and empties when it is not.

Deck Shelves can *nearly* do this now: point a shelf at a collection and add
the `installed` filter — PC GamePak registers a cartridge as a Steam library,
so its games become installed on plug-in and uninstalled on removal, and the
shelf follows. The collection still has to be maintained by hand per cartridge.

Doing it properly needs a filter on *which library folder* a game is installed
in, which Deck Shelves does not have. Raised upstream — the same filter is what
anyone with an SD card wants for a "games on my SD card" shelf.

TODO: link the issue once it is opened.
