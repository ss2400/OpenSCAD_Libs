// power3pin.scad - Snap in 3 Pin power socket mount in OpenSCAD
// Coordinators are center, front face


include <NopSCADlib/lib.scad>

$fn=100;

// Dimensions
FaceW = 27;       // Face Width
FaceH = 27;       // Face Height
FaceL = 3.5;      // Face Length

BodyL = 24-3.5;   // Body Length

// Examples
%translate ([0,0,0])
  ta4();
  
#translate([30,0,0])
  ta4_mount()
    translate([0,0,-2])
      cube([30,30,4], center=true);
  
// TA4 model
module ta4() {
  translate([0,-11,(FaceL-BodyL)/2]) {
    difference() {
      color("Gray")
        union() {
          // Body
          translate([0, 15.6/2, 0])
            cube([17.2, 15.6, BodyL], center=true);
        
          translate([0, 21.8/2, 0])
            cube([8.6, 21.8, BodyL], center=true);

          translate([0, 21.8/2,0])
            cube([24, 9.9, BodyL], center=true);
        
          // Face
          translate([0, 22/2, (BodyL)/2])
            cube([FaceW, FaceH, FaceL], center=true);
        }
        color("Silver") {
          // Ground
          translate([0, 18, (BodyL+FaceL)/2])
            cylinder(d=5.4, h = 15, center=true);
    
          // Blade
          translate([-6.3, 5.3, (BodyL+FaceL)/2])
            cube([3.2, 8, 15], center=true);
      
          // Blade
          translate([6.3, 5.3, (BodyL+FaceL)/2])
            cube([3.2, 8, 15], center=true);
        }
    }
  }
}

// TA4 mount cutout
module ta4_cutout() {
  translate([0,-11,-BodyL/2+0.01]) {
    union() {
      // Body
      translate([0, 22/2, 0])
        cube([17.7, 22, BodyL], center=true);
      
      // Wings
      translate([0, 22/2 , -1.6/2])
        cube([23.6, 10, BodyL-1.6], center=true);
    }
  }
}

// Processing module
module ta4_mount() {
  difference() {
    union() {
      children();
    }
    ta4_cutout();
  }
}