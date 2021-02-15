// nema515snap_mnt.scad - Snap in 3 Pin power socket mount in OpenSCAD
// Coordinators are center, front face

include <NopSCADlib/lib.scad>

$fn=100;

// Dimensions
FaceW = 27;       // Face Width
FaceH = 27;       // Face Height
FaceL = 3.5;      // Face Length
TotalL = 24;      // Face and body length combined
BodyL = TotalL - FaceL;

PanelThick = 1.4;   // See table
SnapCutout = 25.2;  // See table
/*
  X   L
  0.8 24
  1.0 24.6
  1.2 25.2
  1.6 26.2
*/

// Examples
%nema515snap();

translate([34,0,0])
  nema515snap_mount()
    translate([0,0,-2])
      rounded_cube_xy([34,34,4], r=3, xy_center=true, z_center=true);

// Model
module nema515snap() {
  // Measurements taken from real part and drawing
  // XY Center @ origin
  // Face above Z origin
  offset = 11;
  z = FaceL;
  
  translate([0,0,(z-BodyL)/2]) {
    difference() {
      color("Gray")
        union() {
          // Wide body section (blades)
          translate([0, 6/2-offset, 0])
            cube([17.2, 6, BodyL], center=true);
        
          // Narrow body section (ground)
          cube([8.6, 21.8, BodyL], center=true);

          // Snap section
          cube([24, 9.9, BodyL], center=true);
        
          // Face
          translate([0, 0, (BodyL)/2])
            cube([FaceW, FaceH, FaceL], center=true);
        }
        color("Silver") {
          // Ground cut
          translate([0, 7, (BodyL+FaceL)/2])
            cylinder(d=5.4, h = 15, center=true);
    
          // Blade cut
          translate([-6.35, -4.9, (BodyL+FaceL)/2])
            cube([3.2, 8, 15], center=true);
      
          // Blade cut
          translate([6.35, -4.9, (BodyL+FaceL)/2])
            cube([3.2, 8, 15], center=true);
        }
    }
  }
}

// Mount cutout
module nema515snap_cutout() {
  // Measurements from panel cut-out drawing
  // XY Center @ origin
  // Surface a smidgen above Z origin @ z=0.01
  offset = 11;
  z = 0.01;
  
  // Set face surface 
  translate([0,0,-BodyL/2+z]) {
    union() {
      // Wide body section (blades)
      translate([0, 6/2-offset, 0])
        cube([18, 6.3, BodyL], center=true);
        
      // Narrow body section (ground)
      cube([9.3, 22.3, BodyL], center=true);
        
      // Snap clearance L = 24 to 26.2
      cube([SnapCutout, 10.7, BodyL], center=true);
      
      // Set effective panel thickness (0.8mm to 1.6mm) for snaps
      translate([0, 0 , -PanelThick/2])
        cube([SnapCutout+5, 10.6, BodyL-PanelThick], center=true);
    }
  }
}

  
// Processing module
module nema515snap_mount() {
  difference() {
    union() {
      children();
    }
    nema515snap_cutout();
  }
}