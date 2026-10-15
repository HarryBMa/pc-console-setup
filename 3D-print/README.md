# Cyber NUC v3: NFC card slot

189 × 138 × 74 mm. Same as v2 (dust door, keyed rails, SSD sled), plus a front
NFC card slot in the tower, as on the SMS case.

## The card slot

The card goes in flat at the tower front, short edge first, and slides 46 mm
in, leaving about 40 mm out to grab. It runs under the PN532, 2.3 mm below the
board, which is well inside its read range. The reader is centred over the
card.

- **The tower is 22 mm wider**, not the 10 I estimated. A 54 mm card needs a
  56 mm channel, plus walls, plus room for the slot to stay clear of the
  front-right facet, which I also shrank from 4 mm to 2.
- **No bridges.** The bottom edge of the slot is part of the top shell, and the
  top edge is a brow that hangs down from the tower cap. That way neither part
  has to print a 56 mm bridge over the slot.
- **Card carrier.** Behind the slot the card runs in a carrier, a new part
  with a blind channel and a lead-in. It hangs from two posts on the cap.
- **Cap lifts out as a unit.** Cap, brow, carrier and reader come out together.
  I checked this by lifting them 25 mm: nothing catches. For that, the steep
  facet on the tower front now starts at the cap instead of below it.

The tower columns, floor vents and front-right facet moved with the wider
tower. The vertical LED bar on the tower front is shorter, so it stays clear
of the slot.

## Parts (STLs already in print orientation)

| # | file | print |
|---|---|---|
| 01 | bottom_shell (189 × 138 × 48) | floor down |
| 02 | top_shell_ROOF_DOWN | roof down |
| 03 | tower_cap_ROOF_DOWN (70 × 138 × 71, includes the brow) | roof down |
| 04 | **nfc_card_carrier_BACK_DOWN** (59 × 51 × 4.4) | standing on its back face, channel opening upward |
| 05 | dust_door | front face down |
| 06 | bay_tray_PETG | flat, PETG or nylon |
| 07 | backplate_usbc | flat |
| 08 | backplate_sata_TEMPLATE | unmeasured |
| 09 | cartridge_base | floor down |
| 10 | cartridge_lid_TOP_DOWN | top down |
| 11 | ssd_sled | floor down |
| 12 | led_diffusers_TRANSLUCENT | translucent |

None of them need supports.

## Assembly

1. NUC on its posts, hub in its cradle, dongles beside it.
2. Door and pin into the top shell (upside down), clicking past the necks.
3. Tray (4 × M3 × 8 csk), then the backplate (2 × M3 × 8 csk).
4. Top shell on (2 × M3 × 12 csk from underneath).
5. **Cap sub-assembly, upside down on the bench:** PN532 onto its posts
   (4 × M2.5 × 6), then the card carrier onto its two posts (2 × M3 × 10 csk).
6. Cap on (2 × M3 × 12 csk from underneath). The brow drops into its notch at
   the front.

**Shopping list:** 4 × M3 × 12 csk, 6 × M3 × 8 csk, **2 × M3 × 10 csk**,
4 × M2.5 × 6, 4 × M2 × 14 csk per cartridge, 72.5 mm of 1.5 mm steel wire,
about 30 cm of 5 mm LED strip. For the SSD sled: 4 × M3 × 8.

## What I checked

- All parts single-body and watertight.
- No overlaps between printed parts, or between printed parts and the NUC,
  hub, reader, connector, enclosure, door pin or a card pushed fully in.
- Cap + brow + carrier + reader lift out with nothing catching.
- Cartridge, door and rails unchanged from v2: the door swings freely, a
  cartridge goes in right way up with only the detent touching, and the rails
  stop it upside down.

## Still assumed — please measure

The PN532 board (40.2 × 42.7, holes on a 37.5 mm diagonal) and its thickness
with components (5 mm). Also `nuc_holes`, the hub, the enclosure, the SATA
connector, and the 2.5" drive's bottom holes.
