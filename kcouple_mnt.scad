// kcouple_mnt.scad - K Type thermocouple mount in OpenSCAD
// Coordinators are center, front face

include <NopSCADlib/lib.scad>

$fn=100;

// Dimensions
W = 16.9;     // Body Width
H = 7.9;      // Body Height
L = 25.4;     // Body Length
Hole = 2.5;   // Hole Diameter
Offset = 7.1; // Hole offset from front
T = 2;        // Mount lip thickness

Radius = 2;   // Backing radius
Slop = 0.4;   // Fitment slop

// Examples
%kcouple();
translate([22,0,0])
  kcouple_mount(thick=12);

// Model
module kcouple() {
  // Measurements taken from real part and drawing
  // XY Center @ origin
  // Face above Z origin
  difference() {
    // Body
    color("Yellow")
      translate([0, 0, -L/2])
        rounded_cube_xy([W, H, L], r=1, xy_center=true, z_center=true);
    
    color("Silver") {
      // Narrow + terminal
      translate([-3.95, 0, -L/4+0.01])
        cube([2.3, 2, L/2], center=true);

      // Wide - terminal  
      translate([3.95, 0, -L/4+0.01])
        cube([3.3, 2, L/2], center=true);
    }
    
    // Screw hole
    translate([0, 0, -Offset])
      rotate([90, 0, 0])
        cylinder(d=Hole, h=H+20, center=true);
  }    
}

// Mount cutout
module kcouple_cutout() {
  // Measurements taken from real part and drawing
  // XY Center @ origin
  // Face flush @ Z origin

  union() {
    // Body
    translate([0, 0, -L/2+0.01])
      cube([W+Slop, H+Slop, L], center=true);
      
    // Screw hole
    translate([0, 0, -Offset])
      rotate([90, 0, 0])
        cylinder(d=Hole+Slop, h=H+20, center=true);
  }
}

// Processing module
module kcouple_mount(thick=10) {
  difference() {
    union() {
      children();
        translate([0, 0, -thick/2])
          rounded_cube_xy([W+T*2, H+T*2,thick], r=Radius, xy_center=true, z_center=true);
    }
    kcouple_cutout();
  }
}