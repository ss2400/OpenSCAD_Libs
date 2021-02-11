// ta4_mnt.scad - TA4 PID controller mount in OpenSCAD
// Coordinators are center, front face

include <NopSCADlib/lib.scad>

$fn=100;

// Body dimensions
W = 45;         // Body Width
H = 45;         // Body Height
L = 110;        // Body Length

BezelW = 48;    // Bezel Width
BezelH = 48;    // Bezel Height
BezelL = 6.5;   // Bezel Length

Slop = 0.6;    // Fitment slop

// Examples
%ta4();
translate([60,0,0])
  ta4_mount(thick=10);
  
// TA4 model
module ta4() {
  union() {
    // Body
    translate([0, 0, -L/2-BezelL])
      color("Gray")
        cube([W, H, L], center=true);

    // Face Bezel
    translate([0, 0, -BezelL/2])
      color("Black")
        cube([BezelW, BezelH, BezelL], center=true);
  }
}

// TA4 mount cutout
module ta4_cutout() {
  union() {
    // Body
    translate([0, 0, -L/8-BezelL+0.01])
      cube([W+Slop, H+Slop, L/4], center=true);

    // Face Bezel
    translate([0, 0, -BezelL/2-Slop/2])
      cube([BezelW+Slop, BezelH+Slop, BezelL+Slop+0.01], center=true);
  }
}

// Processing module
module ta4_mount(thick=5) {
  difference() {
    union() {
      children();
      translate([0, 0, -thick/2])
        cube([BezelW+10, BezelH+10,thick], center=true);
    }
    ta4_cutout();
  }
}