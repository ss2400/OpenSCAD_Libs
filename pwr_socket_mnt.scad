// power3pin.scad - Snap in 3 Pin power socket mount in OpenSCAD

include <NopSCADlib/lib.scad>

$fn=100;

// Dimensions
FaceW = 27;       // Face Width
FaceH = 27;       // Face Height
FaceL = 3.5;      // Face Length

BodyW = 27;       // Body Width
BodyH = 27;       // Body Height
BodyL = 24;       // Body Length

function FuncX() = [0.8,1.0 ,1.2 ,1.6];
function FuncL() = [24 ,24.6,25.2,26.2];
   

// Examples
//ta4();
translate([0,0,40])
  ta4_mount();
  
// TA4 model
module ta4() {
  union() {
    // Body
    translate([0, 16.3/2, 0])
      color("Gray")
        cube([18.0, 16.3, BodyL-FaceL], center=true);
        
    translate([0, 22/2, 0])
      color("Gray")
        cube([9.1, 22, BodyL-FaceL], center=true);

    translate([0, 22/2 ,0])
      color("Gray")
        cube([24, 10.6, BodyL-FaceL], center=true);
        
    // Face
    translate([0, 22/2 , (BodyL-FaceL)/2])
      color("Gray")
        cube([FaceW, FaceH, FaceL], center=true);
        
  }
}

// TA4 mount cutout
module ta4_cutout() {
  union() {
    // Body
    translate([0, 16.3/2, 0])
      color("Gray")
        cube([18.0, 16.3, BodyL-FaceL], center=true);
        
    translate([0, 22/2, 0])
      color("Gray")
        cube([9.1, 22, BodyL-FaceL], center=true);

    for (i = [0:3]) {
      translate([FuncX(i), 22/2 ,0])
        color("Gray")
          cube([FuncL(i), 10.6, BodyL-FaceL], center=true);
          echo(i);
    }
  }
}
ta4_cutout();

// Processing module
module ta4_mount() {
  difference() {
    union() {
      children();
      //translate([0, 0, -thick/2])
        //cube([BezelW+10, BezelH+10,thick], center=true);
    }
    ta4_cutout();
  }
}