// =============================================================
//  CYBER NUC  v1
//  ASUS NUC 15 Pro Slim enclosure with a front-loading 2.5" drive
//  bay on top. The bay is a true 2.5" envelope (69.85 x 100 x 15),
//  so it takes either your USB-C cartridges or -- with the other
//  backplate -- a SATA SSD in a sled.
//
//  Frame: X across (left 0 .. right W), Y depth (front 0 .. rear D),
//  Z up. The NUC sits in the left section with its rear I/O flush
//  with the back; the bay is directly above it; the USB hub, dongles
//  and the PN532 NFC reader live in the taller right-hand tower.
//
//    part = 1  bottom shell      floor down
//    part = 2  top shell         ROOF DOWN
//    part = 3  bay tray          flat (it carries the detent spring)
//    part = 4  USB-C backplate   flat
//    part = 5  SATA backplate    flat  (template -- measure first)
//    part = 6  cartridge base    floor down
//    part = 7  cartridge lid     top face down
//    part = 8  SSD sled          floor down
//    part = 9  LED diffusers     flat, translucent filament
//    part = 0  assembly preview
// =============================================================

$fa = 2; $fs = 0.4;
L = 1000;

// ---------------------------------------------------------------
//  1. BOUGHT PARTS
// ---------------------------------------------------------------
nuc_w = 117; nuc_d = 113; nuc_h = 34;          // feet off
nuc_holes = [[7, 7], [nuc_w - 7, 7], [7, nuc_d - 7], [nuc_w - 7, nuc_d - 7]];
                                               // *** never verified ***
post_h = 6;  post_od = 9;  post_id = 2.5;

// 2.5" drive envelope, at the tallest standard height
drv_w = 69.85;  drv_l = 100;  drv_h = 15;

// NVMe USB-C enclosure (cartridge payload)
enc_w = 40;  enc_l = 30;  enc_t = 8;           // plug centred on the 40 edge
enc_plug_hole = [11, 5];                       // hole in the partition

// panel-mount USB-C female, filed (from the main build)
fl_w = 25.5;  fl_h = 8.0;  fl_t = 5.0;
fl_scr = 16;  fl_proud = 1.5;  fl_gap = 4.5;   // gap: flange face to drive body
fl_body = 39 - fl_t;                           // 34 behind the flange
head_d = 5.6;  head_t = 1.6;
body_hole = [11, 8.4];

// USB hub, stood on its back so the ports face UP
hub_l = 90;  hub_w = 24;  hub_h = 17;
hub_port_x = 35;  hub_port_l = 50;             // port band, from the cable end
hub_bend = 18;

// PN532
pn_w = 40.2;  pn_d = 42.7;  pn_t = 5.0;
pn_hole_off = 37.5/sqrt(2)/2;
pn_holes = [[pn_w/2 - pn_hole_off, pn_d/2 - pn_hole_off],
            [pn_w/2 + pn_hole_off, pn_d/2 + pn_hole_off],
            [pn_w/2 + pn_hole_off, pn_d/2 - pn_hole_off],
            [pn_w/2 - pn_hole_off, pn_d/2 + pn_hole_off]];

// ---------------------------------------------------------------
//  2. PRINT + FIT
// ---------------------------------------------------------------
wall = 3.0;  roof = 2.5;  floor_t = 3.0;
fit = 0.25;  clr = 0.4;
screw_d = 3.4;  csk_d = 6.4;  pilot = 2.5;
m2_pilot = 1.6;  m2_d = 2.3;  m2_csk = 4.0;

// ---------------------------------------------------------------
//  3. LAYOUT
// ---------------------------------------------------------------
W = 189;  D = 138;                             // v3: +22 for the NFC card slot
nuc_x = 3.5;  nuc_y = D - wall - nuc_d;        // 22 -- rear I/O flush
nuc_z = floor_t + post_h;                      // 9

// bay: a tunnel above the NUC, front-loaded
bay_x0  = 18;                                  // clear of the big front-left facet
bay_w   = drv_w + 2*clr;                       // 70.65
bay_h   = drv_h + 0.8;                         // 15.8 -- the drive rests on the floor
tray_t  = 2.5;
tray_z0 = nuc_z + nuc_h + 1.0;                 // 44.0, 1.0 over the NUC
bay_z0  = tray_z0 + tray_t;                    // 46.5 -- floor the drive rests on
bay_z1  = bay_z0 + bay_h;                      // 62.3
// ---- DOOR (v2): one dust door across the slot, hinged at the top ----
// It hangs just behind the front wall and is pushed up and in by the
// cartridge; with the cartridge out it falls shut under its own weight
// (hinged at the top, it cannot stay open). It overlaps the brow above
// the mouth, so it cannot swing outward.
// Panel front face tangent to the hinge boss, so it prints flat on that
// face with no support.
pin_d   = 1.5;                                 // steel pin / straightened paperclip
d_t     = 1.6;                                 // panel
d_rb    = 1.6;                                 // hinge boss radius
d_hy    = wall + 0.3 + d_rb;                   // 4.9 -- axis, Y
d_hz    = bay_z0 + drv_h + 0.6 + d_rb;         // 63.7 -- open, the panel clears a cartridge by 0.6
d_L     = d_hz - (bay_z0 + 0.3);               // 16.9 -- axis to bottom edge
d_w     = bay_w - 0.8;                         // 0.4 each side to the tunnel walls
door_room = d_hz + d_rb + 0.3 - bay_z1;        // 3.3 -- extra headroom in the tunnel
// pin seats: grooves in the inner faces of the tunnel walls, open at the
// bottom, so the door goes in with its pin from below (top shell upside
// down) and clicks past a neck
pg_dep  = 1.0;  pg_w = pin_d + 0.1;  pg_neck = pin_d - 0.2;
pin_len = bay_w + 2*pg_dep - 0.2;              // 72.45

// v2: the roof rises door_room over the tunnel, so the dust door has
// somewhere to fold up to above a cartridge (see DOOR below)
Hm      = bay_z1 + door_room + roof;           // 68.1 main roof
Ht      = Hm + 6.2;                            // 74.3 tower roof
SPLIT   = tray_z0;                             // shells part where the tray starts
bw      = 2.0;                                 // tunnel side walls

proud   = 12;                                  // drive front stands this far out
bp_y    = drv_l - proud;                       // 88 -- backplate front face
bp_t    = 4;

// where things line up when a drive is home
drv_x0  = bay_x0 + clr;                        // the drive is centred by the walls
plug_x  = drv_x0 + drv_w/2;                    // 53.3
plug_z  = bay_z0 + drv_h/2;                    // 54.0

// tunnel bosses: the tray screws up into them, the backplate into the
// rear pair from behind
bos_d = 7;
bos_pos = [[bay_x0 - bw - 1.5, 10], [bay_x0 + bay_w + bw + 1.5, 10],
           [bay_x0 - bw - 1.5, bp_y - bos_d/2], [bay_x0 + bay_w + bw + 1.5, bp_y - bos_d/2]];

// the right-hand tower
tw_x0 = 119;                                   // outer left face of the tower
hub_x = 124;  hub_y = 40;                      // hub stands X 124..141
// ---- NFC CARD SLOT (v3) ----
// The card goes in at the tower front, flat, short edge first, under
// the PN532 -- as on the SMS case. 54 mm of card needs 59 mm of carrier,
// which is why the tower is 22 mm wider than in v2 (42 inside, now 64).
//
// The mouth is split between two parts so nothing bridges: its lower
// lip is the top shell, its upper lip is a BROW that hangs down from
// the tower cap. Behind the mouth the card runs in a CARRIER (its own
// part), screwed up into two posts on the cap. Cap, brow, carrier and
// reader all lift out as one.
card_w  = 56;     // 54 mm short edge + 1 each side
card_h  = 2;      // a card is 0.76
card_in = 46;     // how far it goes in; ~40 mm stays out to grab
ch_cw   = 1.6;    // carrier side walls
ch_f    = 1.2;    // carrier floor and roof
m_bot   = 57.5;   // card channel floor, Z
m_top   = m_bot + card_h;
ch_x0   = tw_x0 + wall + 0.3 + ch_cw;          // 123.9 channel left edge
ch_x1   = ch_x0 + card_w;                      // 179.9
ch_y0   = wall + 0.3;                          // carrier front face
cr_x0   = ch_x0 - ch_cw;  cr_x1 = ch_x1 + ch_cw;
cr_y1   = 54;                                  // carrier back
cr_z0   = m_bot - ch_f;  cr_z1 = m_top + ch_f; // 56.3 .. 60.7
br_x0   = ch_x0 - 1.5;  br_x1 = ch_x1 + 1.5;   // brow, X: just the mouth flare
cr_lug  = [[cr_x0 + 3.5, cr_y1 - 3.5], [cr_x1 - 3.5, cr_y1 - 3.5]];

pn_x  = (ch_x0 + ch_x1)/2 - pn_w/2;            // reader centred over the card
pn_y  = ch_y0 + 1.2;
pn_post = Ht - roof - (cr_z1 + 0.3 + pn_t);    // board hangs 0.3 over the carrier
assert(br_x1 + fit + 0.8 <= W - 2 - 3*sqrt(2), "the card mouth runs into the front-right facet");

// shell screws: four columns hung from the top shell, screwed from below
col_d = 8;
// The front pair sit either side of the tray, NOT on the tray bosses:
// a column that runs to the floor would pass straight through the tray
// it is meant to hold up.
// Each column stands at least 6.8 mm (centre) off every inner wall, so
// the register lip runs past it unbroken. Nearer than that, the lip
// notch and the bottom shell's clearance ring left 0.03-0.3 mm slivers
// of wall and a visible slit in the outer skin.
col_pos = [[11, 17.5], [102, 17.5], [W - 10, 66], [W - 12, 122]];
col_min = 6.8;
col_top = [Hm - roof + 0.5, Hm - roof + 0.5, Ht - roof + 0.5, Ht - roof + 0.5];

// ---- RAILS (v2): one on each tunnel wall, in a groove down each side
// of the cartridge. At different heights left and right, so a cartridge
// upside down stops at the first 24 mm of the rails instead of meeting
// the connector crooked. They also hold it to +-0.3 mm vertically.
key_l   = 3.0;                                 // rail underside above the tunnel floor, left
key_r   = 5.3;                                 //   ... right
// (both grooves sit below 8 mm so the SSD sled -- an 8 mm plate under
//  a 7 mm drive -- can carry them too)
r_p     = 1.0;  r_h = 1.8;                     // protrusion, height (45 deg top; 0.8 at the tip)
r_y0    = d_hy + d_L + 3;                      // 24.8 -- behind the door's swing
g_d     = 1.2;                                 // groove depth in the cartridge side
g_y0    = 30;                                  // groove front end, cartridge local Y

// cartridge detent
det_y   = 69;                                  // bump, world Y
det_len = 16;                                  // tongue length (root at the rear)
det_w   = 10;  det_bump = 0.8;

assert(tray_z0 - (nuc_z + nuc_h) >= det_bump + 0.15,
       "the detent tongue cannot deflect under the tray");
assert(bp_y + fl_body + 12 < D - wall, "no room behind the backplate for the cable");

// ---------------------------------------------------------------
//  4. THE ENVELOPE -- every face is a half-space, so the inner
//     surface is the same planes moved in by the wall. Exact walls
//     on every facet, which is what makes a faceted body printable.
// ---------------------------------------------------------------
function P(n, d) = [n/norm(n), d/norm(n)];          // keep n.p <= d
module hs(pl, off = 0) {
  n = pl[0];  d = pl[1] - off;
  translate(n*d)
    rotate([0, acos(n[2]), atan2(n[1], n[0])])
      translate([-L, -L, -2*L]) cube(2*L);
}
module solid(planes, offs) {
  intersection_for (i = [0 : len(planes) - 1]) hs(planes[i], offs[i]);
}

// MAIN: the NUC and the bay
MAIN = [
  P([-1, 0, 0], 0),              // left
  P([ 1, 0, 0], 121),            // runs into the tower -- no wall here
  P([ 0,-1, 0], 0),              // front
  P([ 0, 1, 0], D),              // rear
  P([ 0, 0,-1], 0),              // floor
  P([ 0, 0, 1], Hm),             // roof
  P([-1,-1, 0], -14),            // big front-left facet, in plan
  P([-1, 0, 1], Hm - 8),         // top-left edge, 8
  P([ 0,-1,-1], -6),             // bottom-front edge, 6
  P([-1, 0,-1], -3)              // bottom-left edge, 3
];
MAIN_W = [wall, 0, wall, wall, floor_t, roof, wall, wall, wall, wall];
// (no rear-left facet: any facet there bigger than 2 mm cuts into the
// NUC, whose rear I/O has to sit flush with the back wall)

// TOWER: hub, dongles, NFC -- taller, and faceted differently
TOWER = [
  P([-1, 0, 0], -tw_x0),
  P([ 1, 0, 0], W),
  P([ 0,-1, 0], 0),
  P([ 0, 1, 0], D),
  P([ 0, 0,-1], 0),
  P([ 0, 0, 1], Ht),
  P([ 1,-1, 0], W - 2),          // small front-right facet (v3: 2, was 4 -- keeps it off the card mouth)
  P([ 1, 1, 0], W + D - 12),     // big rear-right facet
  P([ 0,-1.28, 1], Hm + 1.5),    // steep front face, 52 deg; v3: starts at the cap so the carrier lifts out
  P([ 1, 0, 1], W + Ht - 6),     // top-right edge, 6
  P([-1, 0, 1], Ht - 4 - tw_x0), // top-left edge where it rises off the main roof
  P([ 0,-1,-1], -10)             // bottom-front edge, 10 -- not the main's 6
];
TOWER_W = [wall, wall, wall, wall, floor_t, roof, wall, wall, wall, wall, wall, wall];

module outer() { union() { solid(MAIN, [for (i = MAIN) 0]); solid(TOWER, [for (i = TOWER) 0]); } }
module inner() {
  union() {
    solid(MAIN, MAIN_W);
    solid(TOWER, TOWER_W);
    // open the tower into the main section below the main roof --
    // otherwise the tower's left wall would run the full height
    intersection() {
      translate([tw_x0 - 4, -1, -1]) cube([wall + 8, D + 2, Hm - roof + 1]);
      solid(TOWER, [for (i = [0 : len(TOWER) - 1]) i == 0 ? -10 : TOWER_W[i]]);
    }
  }
}
// a ring just inside the inner surface, for the register lip
module inner_ring(inset, t, z0, z1) {
  intersection() {
    difference() {
      union() { solid(MAIN, [for (w = MAIN_W) w + inset]); solid(TOWER, [for (w = TOWER_W) w + inset]); }
      union() { solid(MAIN, [for (w = MAIN_W) w + inset + t]); solid(TOWER, [for (w = TOWER_W) w + inset + t]); }
    }
    translate([-1, -1, z0]) cube([W + 2, D + 2, z1 - z0]);
  }
}

// ---------------------------------------------------------------
//  5. LED CHANNELS
//     5.2 wide, 2.2 deep: a 5 mm LED strip with a printed diffuser
//     on top. Each has a backer rib inside so the wall behind never
//     drops below wall - depth + led_back.
// ---------------------------------------------------------------
led_w = 5.2;  led_dep = 2.2;  led_back = 2.0;  led_wire = 4;
// [origin, size, inward normal axis (0 X, 1 Y), inward sign]
LEDS = [
  // front face, beside the bay mouth, at the drive's mid-height
  [[bay_x0 + bay_w + bw + 9, -1, plug_z - led_w/2], [113 - (bay_x0 + bay_w + bw + 9), led_dep + 1, led_w], 1, 1],
  // tower front, vertical
  [[133, -1, 14], [led_w, led_dep + 1, 34], 1, 1],
  // tower right side, long horizontal
  [[W - led_dep, 22, 36], [led_dep + 1, 92, led_w], 0, -1]
];
module led_cuts() {
  for (c = LEDS) {
    translate(c[0]) cube(c[1]);
    // wire hole at the inboard end, through the backer
    o = c[0]; s = c[1];
    if (c[2] == 1) translate([o[0] + led_w/2 + (s[0] > led_w ? s[0] - led_w : 0), -1, o[2] + led_w/2 + (s[2] > led_w ? 0 : 0)])
        rotate([-90, 0, 0]) cylinder(d = led_wire, h = wall + led_back + 2);
    else translate([W + 1, o[1] + led_w/2 + 2, o[2] + led_w/2])
        rotate([0, -90, 0]) cylinder(d = led_wire, h = wall + led_back + 2);
  }
}
// g grows the box: used to notch the register lip round a backer
module led_backers(g = 0) {
  for (c = LEDS) {
    o = c[0]; s = c[1];
    // each with a 45 deg chamfer underneath, so it needs no support
    // in the bottom shell (printed floor-down)
    if (c[2] == 1) hull() {
      translate([o[0] - 2 - g, wall - 0.5, o[2] - 2 - g]) cube([s[0] + 4 + 2*g, led_back + 0.5 + g, s[2] + 4 + 2*g]);
      translate([o[0] - 2 - g, wall - 0.5, o[2] - 2 - g - led_back - g]) cube([s[0] + 4 + 2*g, 0.5, 0.01]);
    }
    else hull() {
      translate([W - wall - led_back - g, o[1] - 2 - g, o[2] - 2 - g]) cube([led_back + 0.5 + g, s[1] + 4 + 2*g, s[2] + 4 + 2*g]);
      translate([W - wall, o[1] - 2 - g, o[2] - 2 - g - led_back - g]) cube([0.5, s[1] + 4 + 2*g, 0.01]);
    }
  }
}
// NFC tap zone mark on the tower roof: a channel ring OUTSIDE the
// board's footprint would not fit the tower, so the tap zone gets a
// shallow engraved outline instead (0.6 deep in a 2.5 roof)
module nfc_mark() {
  translate([pn_x + 2, pn_y + 6, Ht - 0.6])
    linear_extrude(1) difference() {
      square([pn_w - 4, pn_d - 8]);
      translate([1, 1]) square([pn_w - 6, pn_d - 10]);
    }
}

// ---------------------------------------------------------------
//  6. OPENINGS
// ---------------------------------------------------------------
alc_x0 = col_pos[0][0] + col_d/2 + 2;          // front alcove onto the NUC
alc_x1 = col_pos[1][0] - col_d/2 - 2;
module openings() {
  // bay mouth, with a 1.5 mm lead-in chamfer
  translate([bay_x0, -1, bay_z0]) cube([bay_w, bp_y + 1, bay_h]);
  hull() {
    translate([bay_x0 - 1.5, -0.01, bay_z0 - 1.5]) cube([bay_w + 3, 0.01, bay_h + 1.5 + 0.01]);
    translate([bay_x0, 1.5, bay_z0]) cube([bay_w, 0.01, bay_h]);
  }
  // front alcove onto the NUC's own front I/O -- a notch up to the
  // split, so the bottom shell has no 70 mm bridge over it
  translate([alc_x0, -1, nuc_z + 3]) cube([alc_x1 - alc_x0, wall + 2, SPLIT - nuc_z - 3 + 0.01]);
  // rear I/O window, also a notch
  translate([nuc_x + 3, D - wall - 1, nuc_z + 3]) cube([nuc_w - 6, wall + 2, SPLIT - nuc_z - 3 + 0.01]);
  // top vents over the space behind the backplate
  for (i = [0 : 12]) translate([14 + i*7, bp_y + 10, Hm - roof - 1]) cube([3.5, 34, roof + 2]);
  // tower right side vents, beside the dongles
  for (i = [0 : 9]) translate([W - wall - 1, 66 + i*6, 8]) cube([wall + 2, 3, 22]);
  // floor vents under the NUC (its intake)
  for (i = [0 : 9]) translate([18 + i*9, nuc_y + 20, -1]) cube([4, 70, floor_t + 2]);
  // tower floor vents
  // (between the two tower columns -- they used to run through the
  //  column screw countersinks)
  for (i = [0 : 3]) translate([W - 23 + i*5, 74, -1]) cube([2.5, 40, floor_t + 2]);
  led_cuts();
  nfc_mark();
  // NFC card mouth, flared top and bottom
  translate([ch_x0, -1, m_bot]) cube([card_w, wall + 2, card_h]);
  hull() {
    translate([ch_x0 - 1.5, -0.01, m_bot - 1.5]) cube([card_w + 3, 0.01, card_h + 3]);
    translate([ch_x0, 1.5, m_bot]) cube([card_w, 0.01, card_h]);
  }
  // panel lines -- offset, asymmetric, 0.8 deep
  translate([-1, 30, Hm - 0.8]) rotate([0, 0, -18]) cube([60, 1.0, 1]);
  translate([tw_x0 + 6, 58, Ht - 0.8]) cube([W - tw_x0 - 14, 1.0, 1]);
  translate([-1, 72, 20]) cube([1.8, D - 76, 1.0]);       // left side
  translate([-1, 72, 20]) cube([1.8, 1.0, 26]);
}

// ---------------------------------------------------------------
//  7. TOP SHELL
// ---------------------------------------------------------------
module tunnel() {
  // side walls, hung from the roof down to the tray
  for (x = [bay_x0 - bw, bay_x0 + bay_w])
    translate([x, wall - 0.5, bay_z0]) cube([bw, bp_y - wall + 0.5, Hm - roof - bay_z0 + 0.5]);
  // bosses -- they stop on the tray, which screws up into them
  // Each is squared off into its tunnel wall, and the rear pair is
  // squared off at bp_y as well: a round boss was only tangent to the
  // backplate's face there, so the plate screwed onto a line contact.
  for (i = [0 : 3]) {
    b = bos_pos[i];  hb = Hm - roof - bay_z0 + 0.5;
    wx = b[0] < plug_x ? bay_x0 - bw/2 : bay_x0 + bay_w + bw/2;   // mid-wall
    translate([0, 0, bay_z0]) hull() {
      translate([b[0], b[1], 0]) cylinder(d = bos_d, h = hb);
      translate([min(b[0], wx), b[1] - bos_d/2, 0]) cube([abs(wx - b[0]), bos_d, hb]);
      if (i >= 2) translate([b[0] - bos_d/2, b[1], 0]) cube([bos_d, bp_y - b[1], hb]);
    }
  }
}
module columns() {
  for (i = [0 : 3]) translate([col_pos[i][0], col_pos[i][1], floor_t + 0.3])
    cylinder(d = col_d, h = col_top[i] - floor_t - 0.3);
}
module pn_posts() {
  for (h = pn_holes) translate([pn_x + h[0], pn_y + h[1], Ht - roof - pn_post + 0.02])
    cylinder(d = 6, h = pn_post + 0.5);
}
// rail profile in (into-tunnel, Z): flat underside, 45 deg top
module rail_prof() { polygon([[-0.5, 0], [r_p, 0], [r_p, r_h - r_p], [-0.5, r_h + 0.5]]); }
module rails() {
  rl = bp_y - 0.5 - r_y0;
  // left: profile runs +X off the wall face at bay_x0
  translate([bay_x0, r_y0, bay_z0 + key_l]) rotate([-90, 0, 0]) mirror([0, 1, 0])
    rail_body(rl);
  translate([bay_x0 + bay_w, r_y0, bay_z0 + key_r]) mirror([1, 0, 0]) rotate([-90, 0, 0]) mirror([0, 1, 0])
    rail_body(rl);
}
// extruded along +Z of its own frame (= +Y in the world), with the
// front 4 mm tapered back into the wall as a lead-in
module rail_body(l) {
  intersection() {
    linear_extrude(l) rail_prof();
    hull() {
      translate([-0.5, -1, 4]) cube([r_p + 0.5, r_h + 2, l - 4]);
      translate([-0.5, -1, 0]) cube([0.5, r_h + 2, 0.01]);
    }
  }
}
module door_seats() {
  for (x = [bay_x0 - pg_dep, bay_x0 + bay_w]) translate([x, 0, 0]) {
    // the slot, open at the bottom of the tunnel wall
    translate([0, d_hy - pg_w/2, bay_z0 - 1]) cube([pg_dep, pg_w, d_hz - bay_z0 + 1]);
    translate([0, d_hy, d_hz]) rotate([0, 90, 0]) cylinder(d = pg_w, h = pg_dep, $fn = 24);
  }
}
module door_necks() {     // added back: narrows the slot to pg_neck just under the seat
  for (x = [bay_x0 - pg_dep, bay_x0 + bay_w]) translate([x, 0, d_hz - pg_w/2 - 1.2])
    difference() {
      translate([0, d_hy - pg_w/2 - 0.01, 0]) cube([pg_dep, pg_w + 0.02, 1.0]);
      translate([-1, d_hy - pg_neck/2, -1]) cube([pg_dep + 2, pg_neck, 3]);
    }
}
module body() {
  union() { difference() {
    intersection() {
      union() {
        difference() { outer(); inner(); }
        tunnel(); columns(); pn_posts(); led_backers(); lug_posts();
      }
      outer();
    }
    openings();
    // pilots
    for (b = bos_pos) translate([b[0], b[1], tray_z0 - 1]) cylinder(d = pilot, h = 9, $fn = 24);
    for (b = [bos_pos[2], bos_pos[3]])
      translate([b[0], bp_y + 1, plug_z]) rotate([90, 0, 0]) cylinder(d = pilot, h = 7, $fn = 24);   // blind: 6 deep
    for (c = col_pos) translate([c[0], c[1], floor_t]) cylinder(d = pilot, h = 13, $fn = 24);
    for (h = pn_holes) translate([pn_x + h[0], pn_y + h[1], Ht - roof - pn_post - 0.5])
      cylinder(d = 2.2, h = pn_post, $fn = 24);
    door_seats();
    for (l = cr_lug) translate([l[0], l[1], cr_z1 - 0.5]) cylinder(d = pilot, h = 8.5, $fn = 24);
  }
  rails();
  door_necks();
  }
}
// The tower's top is its own part, the CAP, split off at the main roof
// height. With the tower 6.2 mm taller than the main roof, a one-piece
// top shell had no face to print on: roof-down, the whole main roof
// (16,800 mm2 of the visible top) hung 6.2 mm over the bed. Now the top
// shell prints roof-down on its flat main roof, and the cap prints
// roof-down on its own. The seam is one more panel line.
//
// The two tower columns belong to the cap: the screws from underneath
// pull the cap down, and the cap clamps the top shell's tower rim.
// The PN532 hangs from the cap, so lifting it off gets at the reader.
CAP_Z = Hm;  CAP_LIP = 3;
tw_cols = [2, 3];
module cap_keep() {      // what goes with the cap
  // (from X tw_x0 + 0.01: the main roof's top face lies in CAP_Z, and
  //  taking it would leave zero-thickness sheets in the cap)
  intersection() { translate([tw_x0 + 0.01, -1, CAP_Z]) cube([W, D + 2, Ht]); solid(TOWER, [for (i = TOWER) 0]); }
  for (i = tw_cols) translate([col_pos[i][0], col_pos[i][1], floor_t + 0.3]) cylinder(d = col_d + 0.01, h = Ht);
  for (h = pn_holes) translate([pn_x + h[0], pn_y + h[1], Ht - roof - pn_post]) cylinder(d = 6.01, h = pn_post + roof);
  brow_zone();
  for (l = cr_lug) translate([l[0], l[1], cr_z1]) cylinder(d = 7.01, h = Ht);
}
module brow_zone() { translate([br_x0, -1, m_top]) cube([br_x1 - br_x0, wall + 1.01, Hm - m_top + 0.01]); }
module lug_posts() {
  for (l = cr_lug) translate([l[0], l[1], cr_z1 + 0.02]) cylinder(d = 7, h = Ht - roof - cr_z1 + 0.5);
}
module top_shell() {
  difference() {
    union() {
      intersection() { body(); translate([-1, -1, SPLIT]) cube([W + 2, D + 2, CAP_Z - SPLIT]); }
      // the main columns go below the split -- keep them with the top shell
      intersection() { body(); union() { for (i = [0, 1]) translate([col_pos[i][0], col_pos[i][1], floor_t + 0.3]) cylinder(d = col_d + 0.01, h = SPLIT); } }
    }
    for (i = tw_cols) translate([col_pos[i][0], col_pos[i][1], 0]) cylinder(d = col_d + 2*fit, h = Ht + 1);
    for (h = pn_holes) translate([pn_x + h[0], pn_y + h[1], Ht - roof - pn_post - 0.5]) cylinder(d = 6 + 2*fit, h = Ht);
    for (l = cr_lug) translate([l[0], l[1], cr_z1 - 0.5]) cylinder(d = 7 + 2*fit, h = Ht);
    // the brow belongs to the cap; fit clearance at its sides
    translate([br_x0 - fit, -2, m_top]) cube([br_x1 - br_x0 + 2*fit, wall + 2.01, Hm]);
  }
}
module tower_cap() {
  intersection() { body(); cap_keep(); }
  // register lip hanging into the top shell's tower rim, across the
  // rear and round the rear-right facet. Not on the left (the top
  // shell's roof runs under it there), nor at the front, where the
  // PN532 sits right up against the walls. The two column screws do
  // the rest of the locating.
  difference() {
    intersection() {
      union() {
        intersection() {
          difference() {
            solid(TOWER, [for (w = TOWER_W) w + fit]);
            solid(TOWER, [for (w = TOWER_W) w + fit + LIP_T]);
          }
          translate([0, 0, CAP_Z - CAP_LIP]) cube([W, D, CAP_LIP + 0.02]);
        }
        // tie-in into the cap wall above the seam: a 1.85 mm ledge,
        // which bridges fine with the cap printed roof-down
        intersection() {
          difference() {
            solid(TOWER, [for (w = TOWER_W) w - 0.5]);
            solid(TOWER, [for (w = TOWER_W) w + fit + LIP_T]);
          }
          translate([0, 0, CAP_Z]) cube([W, D, 0.8]);
        }
      }
      // rear wall and the rear-right facet only: up the right side the
      // top-right facet starts right at the seam, and the lip running
      // along a 45 deg face left 0.04-0.15 mm slivers
      translate([tw_x0 + wall + fit + LIP_T + 1, max(pn_y + pn_d, cr_y1) + 6, CAP_Z - CAP_LIP]) cube([W - 12 - (tw_x0 + wall + fit + LIP_T + 1), D, CAP_LIP + 1]);
    }
    for (i = tw_cols) translate([col_pos[i][0], col_pos[i][1], 0]) cylinder(d = col_d + 2*fit + 0.4, h = Ht);
  }
}

// ---------------------------------------------------------------
//  8. BOTTOM SHELL
// ---------------------------------------------------------------
LIP_H = 4;  LIP_T = 1.6;
module bottom_shell() {
  difference() {
    union() {
      intersection() {
        difference() { outer(); inner(); }
        translate([-1, -1, -1]) cube([W + 2, D + 2, SPLIT + 1]);
      }
      // register lip, notched wherever something crosses it
      difference() {
        union() {
          inner_ring(fit, LIP_T, SPLIT - 0.01, SPLIT + LIP_H);
          inner_ring(-0.5, fit + LIP_T + 0.5, SPLIT - 0.6, SPLIT);  // ties it to the wall,
                                                                  // clear of the NUC's top at 43
        }
        openings();
        translate([-1, -1, SPLIT - 2]) cube([117, 12, LIP_H + 4]);   // from X 0 (across the front-left facet) to past the front LED backer
        for (c = col_pos) translate([c[0], c[1], 0]) cylinder(d = col_d + 2*fit + 0.4, h = Hm);
        led_backers(fit + 0.2);
        // and none over the rear I/O window: it would be a 1.1 mm strip
        // bridging 111 mm with the shell printed floor-down
        translate([nuc_x + 3, D - wall - fit - LIP_T - 1, SPLIT - 2]) cube([nuc_w - 6, 10, LIP_H + 4]);
        // no lip across the main/tower junction: the top shell has no
        // wall there to register against (it opens below the main roof)
        translate([tw_x0 - 4, wall + fit + LIP_T + 1, -1]) cube([wall + 8, D - 2*(wall + fit + LIP_T + 1), Ht]);
      }
      // the LED backers below the split belong to this shell -- the
      // tower-front channel crosses the split, the right-side one is
      // wholly below it
      intersection() {
        led_backers();
        outer();
        translate([-1, -1, -1]) cube([W + 2, D + 2, SPLIT + 1]);
      }
      // NUC posts
      for (h = nuc_holes) translate([nuc_x + h[0], nuc_y + h[1], floor_t - 0.6])
        difference() {
          cylinder(d = post_od, h = post_h + 0.6);
          translate([0, 0, 0.6]) cylinder(d = post_id, h = post_h + 1, $fn = 24);
        }
      // hub cradle: two rails either side of the stood-up hub
      for (x = [hub_x - clr - 1.6, hub_x + hub_h + clr])
        translate([x, hub_y + 4, floor_t - 0.6]) cube([1.6, hub_l - 8, 10.6]);
    }
    openings();
    // column screws, countersunk from underneath
    for (c = col_pos) translate([c[0], c[1], 0]) {
      translate([0, 0, -1]) cylinder(d = screw_d, h = floor_t + 2, $fn = 24);
      translate([0, 0, -0.01]) cylinder(d1 = csk_d, d2 = 0, h = csk_d/2, $fn = 32);
      // and clearance round the column itself
      translate([0, 0, floor_t]) cylinder(d = col_d + 2*fit, h = SPLIT);
    }
  }
}

// ---------------------------------------------------------------
//  9. BAY TRAY -- the tunnel floor, with the detent spring in it
// ---------------------------------------------------------------
module bay_tray() {
  tx0 = bos_pos[0][0] - bos_d/2;  tx1 = bos_pos[1][0] + bos_d/2;
  ty0 = wall + 0.3;
  difference() {
    union() {
      intersection() {
        translate([tx0, ty0, tray_z0]) cube([tx1 - tx0, bp_y - ty0, tray_t]);
        solid(MAIN, [for (w = MAIN_W) w + 0.3]);     // follows the inner facets
      }
      // detent bump, on the tongue's free end, 45 deg both ways
      translate([plug_x - det_w/2 + 1, det_y, bay_z0]) rotate([90, 0, 90])
        linear_extrude(det_w - 2)
          polygon([[-det_bump - 0.6, 0], [-0.6, det_bump], [0.6, det_bump], [det_bump + 0.6, 0]]);
    }
    // U-slot round the tongue: free end at the front, root at the rear
    translate([plug_x - det_w/2 - 1, det_y - 3, tray_z0 - 1])
      difference() {
        cube([det_w + 2, det_len + 1, tray_t + 2]);
        translate([1, 1, -1]) cube([det_w, det_len + 1, tray_t + 4]);
      }
    for (c = col_pos) translate([c[0], c[1], tray_z0 - 1]) cylinder(d = col_d + 2*clr, h = tray_t + 2);
    // screws up into the bosses, countersunk underneath
    for (b = bos_pos) translate([b[0], b[1], tray_z0 - 0.01]) {
      cylinder(d = screw_d, h = tray_t + 1, $fn = 24);
      cylinder(d1 = csk_d, d2 = 0, h = csk_d/2, $fn = 32);
    }
  }
}

// ---------------------------------------------------------------
// 10. BACKPLATES -- swappable, same two screws
// ---------------------------------------------------------------
bp_x0 = bos_pos[0][0] - bos_d/2;  bp_x1 = bos_pos[1][0] + bos_d/2;
module backplate_blank() {
  difference() {
    translate([bp_x0, bp_y, bay_z0]) cube([bp_x1 - bp_x0, bp_t, Hm - roof - bay_z0 - 0.3]);
    for (b = [bos_pos[2], bos_pos[3]])
      translate([b[0], bp_y - 1, plug_z]) rotate([-90, 0, 0]) {
        cylinder(d = screw_d, h = bp_t + 2, $fn = 24);
        translate([0, 0, bp_t + 1 - 1.8]) cylinder(d1 = 0, d2 = csk_d, h = csk_d/2, $fn = 32);
      }
  }
}
module backplate_usbc() {
  difference() {
    backplate_blank();
    // the connector body passes through
    translate([plug_x - body_hole[0]/2, bp_y - 1, plug_z - body_hole[1]/2])
      cube([body_hole[0], bp_t + 2, body_hole[1]]);
    // M3 pilots for the flange, which screws on from the FRONT
    for (m = [-1, 1]) translate([plug_x + m*fl_scr/2, bp_y - 1, plug_z])
      rotate([-90, 0, 0]) cylinder(d = pilot, h = bp_t + 2, $fn = 24);
  }
}
// SATA: a window for the female SATA connector of a 2.5" dock board
// (a cheap SATA-to-USB enclosure PCB), mounted behind the plate.
// *** TEMPLATE. Connector size, its X offset on a 2.5" drive and
// how far it engages are not measured -- set sata_* to your board. ***
sata_win = [42, 8];  sata_x = drv_x0 + 6;  sata_z = bay_z0 + 3;
module backplate_sata() {
  difference() {
    backplate_blank();
    translate([sata_x, bp_y - 1, sata_z]) cube([sata_win[0], bp_t + 2, sata_win[1]]);
    for (m = [-1, 1]) translate([sata_x + sata_win[0]/2 + m*(sata_win[0]/2 + 4), bp_y - 1, sata_z + sata_win[1]/2])
      rotate([-90, 0, 0]) cylinder(d = pilot, h = bp_t + 2, $fn = 24);
  }
}

// ---------------------------------------------------------------
// 11. CARTRIDGE -- a 2.5" drive, 15 mm, in cartridge clothing
//     Local frame: X across (0 .. drv_w), Y from the front grip (0)
//     to the connector end (drv_l), Z up from the underside.
// ---------------------------------------------------------------
cw = 1.6;                                      // shell walls
c_split = 11.5;                                // base / lid
// When home, the drive's rear face is on the backplate. The flange
// face is fl_t in front of it, so the enclosure's body must sit
// fl_gap in front of that -- minus 0.2, so the plug stops short of
// bottoming and the cartridge rests on the plate, never on the plug.
part_t   = 1.6;                                // partition the plug goes through
pocket_d = fl_t + fl_gap - part_t + 0.2;       // 8.1 -- swallows flange, heads, receptacle
enc_back = drv_l - pocket_d - part_t;          // 90.3, local Y of the body's plug face
enc_front= enc_back - enc_l;
enc_x0   = drv_w/2 - enc_w/2;
enc_z0   = cw + (drv_h - 2*cw - enc_t)/2;      // centred: 3.5
pocket   = [fl_w + 1.0, fl_h + 1.0];           // 26.5 x 9.0
det_ly   = det_y + proud;                      // detent notch, local Y = 81
assert(pocket_d > fl_t + head_t + 0.5, "the flange's screw heads reach the pocket floor");
assert(enc_z0 + enc_t <= c_split + 0.01, "the enclosure crosses the base/lid joint");
assert(enc_front > 30, "the enclosure runs into the grip end");
lid_scr = [[5, 18], [drv_w - 5, 18], [5, drv_l - 4], [drv_w - 5, drv_l - 4]];

// the faceted outline in plan: asymmetric front corners
module cart_plan() {
  polygon([[8, 0], [drv_w - 3, 0], [drv_w, 3], [drv_w, drv_l], [0, drv_l], [0, 8]]);
}
module cart_solid() {
  // top-front edge chamfer 3, top-left edge chamfer 2 -- light-catching
  difference() {
    linear_extrude(drv_h) cart_plan();
    translate([-1, 0, drv_h]) rotate([45, 0, 0]) cube([drv_w + 2, 3*sqrt(2), 3*sqrt(2)], center = true);
    translate([0, -1, drv_h]) rotate([0, 45, 0]) cube([2*sqrt(2), 2*drv_l + 2, 2*sqrt(2)], center = true);
  }
}
module cartridge_body() {
  difference() {
    cart_solid();
    // cavity
    translate([cw, cw + 10, cw]) cube([drv_w - 2*cw, enc_back - cw - 10, drv_h - 2*cw]);
    // plug through the partition
    translate([drv_w/2 - enc_plug_hole[0]/2, enc_back - 0.01, enc_z0 + enc_t/2 - enc_plug_hole[1]/2])
      cube([enc_plug_hole[0], part_t + 0.02, enc_plug_hole[1]]);
    // the pocket the flange and receptacle go into
    translate([drv_w/2 - pocket[0]/2, drv_l - pocket_d, drv_h/2 - pocket[1]/2])
      cube([pocket[0], pocket_d + 1, pocket[1]]);
    // grip: three angled grooves across the top of the part that stands out
    for (i = [0 : 2]) translate([10 + i*5, -1, drv_h - 0.6]) rotate([0, 0, 12]) cube([1.2, proud + 2, 1]);
    // label recess
    translate([8, proud + 10, drv_h - 0.5]) cube([drv_w - 16, 52, 1]);
    // light line down the right edge, full length so it shows on the
    // part that stands proud; 0.6 deep leaves 1.0 of side wall
    translate([drv_w - 0.6, 4, drv_h - 2.4]) cube([1, drv_l - 6, 0.8]);   // 1.1 above the lid split
    // detent notch underneath, 45 deg ramps
    translate([drv_w/2 - det_w/2, det_ly, -0.01]) rotate([90, 0, 90])
      linear_extrude(det_w)
        polygon([[-det_bump - 0.9, 0], [-0.7, det_bump + 0.1], [0.7, det_bump + 0.1], [det_bump + 0.9, 0]]);
  }
  // enclosure seat pads under it, so it sits at mid-height
  translate([enc_x0 - 1, enc_front, cw - 0.01]) cube([enc_w + 2, enc_l, enc_z0 - cw + 0.01]);
  // lid screw columns
  // run right through the split up to the lid's plate: the front pair
  // sit in the cavity, and stopping them at the split left the M2s
  // 0.6 mm of lid plate to bite on
  for (s = lid_scr) translate([s[0], s[1], cw - 0.01]) cylinder(d = 5, h = drv_h - 2*cw + 0.02);
}
// the groove: flat floor, 45 deg roof, so the base prints floor-down
// without support. Open at the back, closed 30 mm from the front.
module groove_prof(k) {
  // roof line z = k + r_h + 0.2 - u: 0.6 over the rail's sloped top all the way in
  polygon([[-1, k - 0.3], [g_d, k - 0.3], [g_d, k + r_h + 0.2 - g_d], [0, k + r_h + 0.2], [-1, k + r_h + 1.2]]);
}
module side_grooves() {
  translate([0, drv_l + 1, 0]) rotate([90, 0, 0]) linear_extrude(drv_l + 1 - g_y0) groove_prof(key_l);
  translate([drv_w, 0, 0]) mirror([1, 0, 0])
    translate([0, drv_l + 1, 0]) rotate([90, 0, 0]) linear_extrude(drv_l + 1 - g_y0) groove_prof(key_r);
}
// thickening inside the side walls behind the grooves
module side_ribs() {
  for (k = [[0, key_l], [1, key_r]]) {
    x = k[0] == 0 ? cw - 0.01 : drv_w - cw - 1.6 + 0.01;
    translate([x, g_y0 - 2, cw - 0.01]) cube([1.6, enc_back - g_y0 + 2.02, k[1] + r_h + 0.2 + 1.0 - cw]);
  }
}
module cartridge_full() {
  difference() { union() { cartridge_body(); side_ribs(); } side_grooves(); }
}
module cartridge_base() {
  difference() {
    intersection() { cartridge_full(); translate([-1, -1, -1]) cube([drv_w + 2, drv_l + 2, c_split + 1]); }
    for (s = lid_scr) translate([s[0], s[1], -0.01]) {
      cylinder(d = m2_d, h = c_split + 1, $fn = 20);
      cylinder(d1 = m2_csk, d2 = 0, h = m2_csk/2, $fn = 24);
    }
  }
}
module cartridge_lid() {
  difference() {
    intersection() { cartridge_full(); translate([-1, -1, c_split]) cube([drv_w + 2, drv_l + 2, drv_h]); }
    for (s = lid_scr) translate([s[0], s[1], c_split - 0.01]) cylinder(d = m2_pilot, h = 2.5, $fn = 20);
  }
}

// ---------------------------------------------------------------
// 12. SSD SLED -- for anyone using a bare 2.5" SATA SSD instead of a
//     cartridge. v1's sled was wrong: it put walls round the drive, but a
//     2.5" drive is already the full 69.85 width of the bay. Now it is an
//     8 mm plate UNDER a 7 mm drive -- 15 mm together, the same envelope
//     as a cartridge -- carrying the side grooves and the detent notch.
//     The drive screws on through its four bottom holes (M3 x 8 from
//     underneath, heads in counterbores). The hole positions are slotted
//     +-3.5 mm in Y because I have not checked them against a real drive.
//     The SATA connector is the drive's own, at the back.
// ---------------------------------------------------------------
ssd_h = 7;  sled_t = drv_h - ssd_h;            // 8
ssd_hx = [4.07, 4.07 + 61.72];                 // bottom holes across the width
ssd_hy = [9.5, 86.5];                          // ... along it, from the front -- UNVERIFIED
assert(key_r + r_h + 0.2 + 0.5 <= sled_t, "the right groove runs out of the top of the sled");
module ssd_sled() {
  difference() {
    linear_extrude(sled_t) offset(delta = -1.5, chamfer = true) offset(delta = 1.5) square([drv_w, drv_l]);
    side_grooves();
    // weight: pocket from the top, under the drive
    translate([7, 22, 4]) cube([drv_w - 14, 56, sled_t]);
    for (x = ssd_hx, y = ssd_hy) {
      hull() for (dy = [-3.5, 3.5]) translate([x, y + dy, -1]) cylinder(d = 3.4, h = sled_t + 2, $fn = 20);
      hull() for (dy = [-3.5, 3.5]) translate([x, y + dy, -0.01]) cylinder(d = 6, h = 2.0, $fn = 32);   // 0.7 under the left groove
    }
    translate([drv_w/2 - det_w/2, det_ly, -0.01]) rotate([90, 0, 90]) linear_extrude(det_w)
      polygon([[-det_bump - 0.9, 0], [-0.7, det_bump + 0.1], [0.7, det_bump + 0.1], [det_bump + 0.9, 0]]);
  }
}
module mock_ssd() { translate([0, 0, sled_t]) cube([drv_w, drv_l, ssd_h]); }

// ---------------------------------------------------------------
// 15. NFC CARD CARRIER -- the channel behind the mouth. Hangs from two
//     posts on the cap (2 x M3 x 10 csk from underneath). Prints
//     standing on its back face: the channel then opens upward and
//     nothing bridges more than 2 mm.
// ---------------------------------------------------------------
module card_carrier() {
  difference() {
    intersection() {
      translate([cr_x0, ch_y0, cr_z0]) cube([cr_x1 - cr_x0, cr_y1 - ch_y0, cr_z1 - cr_z0]);
      solid(TOWER, [for (w = TOWER_W) w + 0.3]);       // follows the front-right facet
    }
    // the channel, closed at card_in
    translate([ch_x0, ch_y0 - 1, m_bot]) cube([card_w, card_in - ch_y0 + 1, card_h]);
    // lead-in where the card leaves the mouth
    hull() {
      translate([ch_x0 - 0.8, ch_y0 - 0.01, m_bot - 0.8]) cube([card_w + 1.6, 0.01, card_h + 1.6]);
      translate([ch_x0, ch_y0 + 1, m_bot]) cube([card_w, 0.01, card_h]);
    }
    // screws up into the cap posts, countersunk underneath
    for (l = cr_lug) translate([l[0], l[1], cr_z0 - 0.01]) {
      cylinder(d = screw_d, h = 10, $fn = 24);
      cylinder(d1 = csk_d, d2 = 0, h = csk_d/2, $fn = 32);
    }
  }
}

// ---------------------------------------------------------------
// 14. DUST DOOR -- local frame: hinge axis on X from 0 to d_w, panel
//     hanging down (-Z), its front face at y = -d_rb, tangent to the boss
// ---------------------------------------------------------------
module door_local() {
  difference() {
    union() {
      rotate([0, 90, 0]) cylinder(r = d_rb, h = d_w, $fn = 40);
      // panel, with its bottom edge rounded on the inside so it rides
      // up over a cartridge
      hull() {
        translate([0, -d_rb, -d_L + d_t/2]) cube([d_w, d_t, d_L - d_t/2]);
        translate([0, -d_rb + d_t/2, -d_L + d_t/2]) rotate([0, 90, 0]) cylinder(d = d_t, h = d_w, $fn = 24);
      }
    }
    // pin: a running fit -- the door turns on it. The pin can't wander
    // sideways (0.2 mm end play between the bottoms of the wall slots)
    // or drop out (the slot necks), so nothing needs pressing in.
    translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d = pin_d + 0.2, h = d_w + 2, $fn = 20);
    // face detail: two engraved lines, offset -- light catches them
    // through the slot
    translate([6, -d_rb - 0.01, -d_L*0.42]) cube([d_w - 22, 0.6, 1.0]);
    translate([16, -d_rb - 0.01, -d_L*0.42 - 2.4]) cube([d_w - 22, 0.6, 1.0]);
  }
}
// a = 0 shut, 90 fully up
module door(a = 0) { translate([bay_x0 + 0.4, d_hy, d_hz]) rotate([a, 0, 0]) door_local(); }
module mock_pin()  { translate([bay_x0 + bay_w/2 - pin_len/2, d_hy, d_hz]) rotate([0, 90, 0]) cylinder(d = pin_d, h = pin_len, $fn = 16); }

// ---------------------------------------------------------------
// 13. LED DIFFUSERS -- print in translucent; each snaps over a strip
// ---------------------------------------------------------------
module diffusers() {
  for (i = [0 : len(LEDS) - 1]) {
    s = LEDS[i][1];
    len_ = LEDS[i][2] == 1 ? max(s[0], s[2]) : s[1];
    translate([0, i*8, 0]) cube([len_ - 0.4, led_w - 0.3, 1.0]);
  }
}

// ---------------------------------------------------------------
//  MOCKS
// ---------------------------------------------------------------
module mock_nuc()  { translate([nuc_x, nuc_y, nuc_z]) cube([nuc_w, nuc_d, nuc_h]); }
module mock_hub()  { translate([hub_x, hub_y, floor_t]) cube([hub_h, hub_l, hub_w]); }
module mock_pn()   { translate([pn_x, pn_y, Ht - roof - pn_post - pn_t]) cube([pn_w, pn_d, pn_t]); }
module mock_card() { translate([ch_x0 + 1, card_in - 85.6, m_bot + 0.6]) cube([54, 85.6, 0.76]); }
module mock_conn() {
  translate([plug_x - fl_w/2, bp_y - fl_t, plug_z - fl_h/2]) cube([fl_w, fl_t, fl_h]);
  for (m = [-1, 1]) translate([plug_x + m*fl_scr/2, bp_y - fl_t, plug_z]) rotate([90, 0, 0]) cylinder(d = head_d, h = head_t);
  translate([plug_x - 4.5, bp_y - fl_t - fl_proud, plug_z - 1.6]) cube([9, fl_proud, 3.2]);
  translate([plug_x - body_hole[0]/2 + 0.5, bp_y, plug_z - body_hole[1]/2 + 0.4]) cube([body_hole[0] - 1, fl_body, body_hole[1] - 0.8]);
}
module mock_enc() { translate([enc_x0, enc_front, enc_z0]) cube([enc_w, enc_l, enc_t]); }
// a cartridge placed home in the bay
module home() { translate([drv_x0, -proud, bay_z0]) children(); }

part = 0;
if (part == 1) bottom_shell();
if (part == 2) top_shell();
if (part == 3) bay_tray();
if (part == 4) backplate_usbc();
if (part == 5) backplate_sata();
if (part == 6) cartridge_base();
if (part == 7) cartridge_lid();
if (part == 8) ssd_sled();
if (part == 9) diffusers();
if (part == 10) tower_cap();
if (part == 12) rotate([-90, 0, 0]) card_carrier();   // back face down: channel opens upward, nothing bridges
if (part == 11) rotate([90, 0, 0]) translate([0, d_rb, 0]) door_local();   // front face down
if (part == 0) {
  color("dimgray") bottom_shell();
  color("darkslategray") top_shell();
  color("slategray") tower_cap();
  color("dimgray") card_carrier();
  color("gray") bay_tray();
  color("gold") backplate_usbc();
  color("hotpink") door(87);
  home() { color("black") cartridge_base(); color("magenta") cartridge_lid(); }
}
if (part == 100) {     // exploded
  color("dimgray") bottom_shell();
  color("gray") translate([0, 0, 25]) bay_tray();
  color("darkslategray") translate([0, 0, 55]) top_shell();
  color("slategray") translate([0, 0, 85]) tower_cap();
  color("gold") translate([0, 60, 55]) backplate_usbc();
  color("deepskyblue") translate([0, 0, 55]) mock_pn();
  color("green") mock_hub();  color("silver") mock_nuc();
  translate([0, -110, 55]) home() { color("black") cartridge_base(); color("magenta") translate([0, 0, 18]) cartridge_lid(); }
}
if (part == 101) {     // assembled with the cartridge half out
  color("dimgray") bottom_shell();
  color("darkslategray") top_shell();
  color("slategray") tower_cap();
  color("dimgray") card_carrier();
  color("gray") bay_tray();
  translate([0, -45, 0]) home() { color("black") cartridge_base(); color("magenta") cartridge_lid(); }
  color("cyan") for (c = LEDS) translate(c[0] + [c[2] == 1 ? 0 : 0, c[2] == 1 ? 1 : 0, 0]) cube(c[1] - [c[2] == 1 ? 0 : 1, c[2] == 1 ? 1 : 0, 0]);
}
// mocks, for the checks
if (part == 90) mock_nuc();
if (part == 91) mock_hub();
if (part == 92) mock_pn();
if (part == 97) door(0);
if (part == 87) card_carrier();
if (part == 86) mock_card();
if (part == 98) mock_pin();
if (part == 89) home() ssd_sled();
if (part == 88) home() mock_ssd();
if (part == 93) mock_conn();
if (part == 94) home() mock_enc();
if (part == 95) home() cartridge_base();
if (part == 96) home() cartridge_lid();
