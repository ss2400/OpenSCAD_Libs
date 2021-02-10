// power3pin.scad - Snap in 3 Pin power socket mount in OpenSCAD

include <NopSCADlib/lib.scad>

$fn=100;

// Body dimensions
BodyW = 27;   // Body Width
BodyH = 27;   // Body Height
BodyL = 110;  // Body Length

FaceW = 48;   // Bezel Width
FaceH = 48;   // Bezel Height
FaceL = 5;    // Bezel Length

// Examples
ta4();
translate([0,0,40])
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