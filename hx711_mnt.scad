// hx711_mnt.scad - HX711 Mount in OpenSCAD

include <NopSCADlib/lib.scad>

$fn=100;

// PCB dimensions
L = 33.6;       // PCB Length
W = 20.5;       // PCB Width
T = 1.6;        // PCB Thickness
Hole = 3;       // Hole size
OffsetL = 4.5;  // Hole offset from edge
OffsetW = 3.0;  // Hole offset from edge
Keepout = 10;   // Connector keep out

Post = 5;       // Post thickness (except with screw)
Screw = 1.95;   // Screw hole size
Slop = 0.18;    // Fitment slop

// Examples
hx711(h=5);
hx711_mount(h=5);
translate([-4,-4,0])
  cube([40,28,2]);
  
// HX711 model
module hx711(h=5, center=false) {
  translate([0, 0, 0.01]) {
    difference() {
      // PCB
      translate([0, 0, h])
        color("ForestGreen")
          cube([L, W, T]);

      // Holes
      translate([L-OffsetL, OffsetW, h+T/2])
        cylinder(h = 2*T, d = Hole, center = true);
      translate([L-OffsetL, W-OffsetW, h+T/2])
        cylinder(h = 2*T, d = Hole, center = true);
    }
  }
}

// HX711 posts
module hx711_mount(h=5, center=false) {
  // Mount parameters
  Mnt_H =  h + T*2.5;
  Mnt_W = W;
  Mnt_L = L - OffsetL;

  difference() {
    union() {
    // Create front
    translate([0, 0, 0])
      rounded_cylinder(r=Post/2, h=Mnt_H, r2=0.5, ir=0, angle=360);
    translate([0, Mnt_W, 0])
      rounded_cylinder(r=Post/2, h=Mnt_H, r2=0.5, ir=0, angle=360);
      
    // Create rear  
    translate([Mnt_L, OffsetW, 0])
      rounded_cylinder(r=Screw+1, h=h+T, r2=0.5, ir=Screw/2, angle=360);
    translate([Mnt_L, Mnt_W-OffsetW, 0])
      rounded_cylinder(r=Screw+1, h=h+T, r2=0.5, ir=Screw/2, angle=360);
    }
    
    // Remove PCB
    translate([-Slop, -Slop, h])
      cube([L, Mnt_W+Slop*2, T+Slop*2]);
      
    // Remove section from posts
    translate([L-OffsetL, Mnt_W/2, 0])
      cube([Mnt_L/2, Keepout, Mnt_H*2], center = true);    
  }
}