// ta4_mnt.scad - TA4 PID controller mount in OpenSCAD
// Coordinators are center, front face

include <NopSCADlib/lib.scad>

$fn=100;

// Dimensions
W = 45;         // Body Width
H = 45;         // Body Height
L = 110;        // Body Length

BezelW = 48;    // Bezel Width
BezelH = 48;    // Bezel Height
BezelL = 8;     // Bezel Length

Radius = 4;     // Backing radius
Slop = 0.6;     // Fitment slop

// Examples
%ta4(offset=5);
translate([60,0,0])
  ta4_mount(thick=10, offset=5);

// Model
module ta4(offset=0) {
  // Measurements taken from real part and drawing
  // XY Center @ origin
  // Face above Z origin

  union() {
    // Body
    color("Gray")
      translate([0, 0, -L/2-offset])
        cube([W, H, L], center=true);

    // Face Bezel
    color("Black")
    translate([0, 0, BezelL/2-offset])
      cube([BezelW, BezelH, BezelL], center=true);
  }
}

// Mount cutout
module ta4_cutout() {
  // Measurements taken from real part and drawing
  // XY Center @ origin
  // Face flush @ Z origin

  union() {
    // Body
    translate([0, 0, -L/8+0.02])
      cube([W+Slop, H+Slop, L/4], center=true);

    // Face Bezel
    translate([0, 0, BezelL/2+0.01])
      cube([BezelW+Slop, BezelH+Slop, BezelL+0.01], center=true);
  }
}

// Processing module
module ta4_mount(thick=10, offset=0) {
  difference() {
    union() {
      children();
      translate([0, 0, -thick/2])
        rounded_cube_xy([BezelW+10, BezelH+10,thick], r=Radius, xy_center=true, z_center=true);
    }
    translate([0, 0, -offset])
      ta4_cutout();
  }
}