// hx711.scad - HX711 Mount in OpenSCAD

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
include <Round-Anything/MinkowskiRound.scad>

$fn=100;

// PCB dimensions
L = 33.6;       // PCB Length
W = 20.5;       // PCB Width
T = 1.6;        // PCB Thickness
Hole = 3;       // Hole size
OffsetL = 4.5;  // Hole offset from edge
OffsetW = 3.0;  // Hole offset from edge

Mnt_T = 5;      // Mount thickness
Screw = 2.5;      // Screw size
Slop = 0.1;     // Fitment slop

// Examples
hx711(h=5);
hx711_mount(h=5);
translate([-4,-4,0])
  cube([40,28,2]);
  
module hx711(h=5, center=false) {
  translate([0, 0, 0]) {
    difference() {
      // PCB
      translate([0, 0, h])
        %cube([L, W, T]);

      // Posts
      translate([L-OffsetL, OffsetW, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
      translate([L-OffsetL, W-OffsetW, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
    }
  }
}

module hx711_mount(h=5, center=false) {
  // Mount parameters
  Mnt_H =  h + T*2;
  Mnt_W = W;
  Mnt_L = L - OffsetL;

  difference() {
    union() {
    // Create front
    translate([0, 0, 0])
      cylinder(h=Mnt_H, d = Mnt_T);
    translate([0, Mnt_W, 0])
      cylinder(h=Mnt_H, d = Mnt_T);
      
    // Create rear  
    translate([Mnt_L, OffsetW, 0])
      tube(h=h+T, id=Screw, od=Screw*3);
    translate([Mnt_L, Mnt_W-OffsetW, 0])
      tube(h=h+T, id=Screw, od=Screw*3);
    }
    
    // Remove PCB
    translate([-Slop, -Slop, h])
      cube([L, Mnt_W+Slop*2, T+Slop]);
      
    // Remove section from posts
    translate([L-OffsetL, Mnt_W/2, 0])
      cube([Mnt_L/2, Mnt_W-Screw*4, Mnt_H*2], center = true);    
  }
}
