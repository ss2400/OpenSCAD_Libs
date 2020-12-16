// nano.scad - Arduino Nano Mount in OpenSCAD

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
include <Round-Anything/MinkowskiRound.scad>

$fn=20;

// PCB dimensions
L = 43.18;      // PCB Length
W = 17.78;      // PCB Width
T = 1.6;        // PCB Thickness
Hole = 1.77;    // Hole size
Offset = 1.27;  // Hole offset from edge

Mnt_T = 2.2;    // Mount thickness
Screw = 2;      // Screw size
Slop = 0.15;    // Fitments slop

// Examples
nano(h=10);
nano_mount(h=10);
cube([50,22,3]);

module nano(h=5) {
  translate([Mnt_T/2, Mnt_T, 0]) {
  
    translate([3, W/2, h+T+2])
      rotate([0,180,270])
        %import("models/587.stl", convexity=4);
  
    difference() {
      // PCB
      translate([0, 0, h])
        %cube([L, W, T]);

      // Holes
      translate([L-Offset, W-Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
      translate([L-Offset, Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true);
      translate([Offset, W-Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true); 
      translate([Offset, Offset, h+T/2])
        %cylinder(h = 2*T, d = Hole, center = true); 
    }
  }
}

module nano_mount(h=5) {
	// Mount parameters
	Mnt_H = h + T + 1;
	Mnt_L = L + 2;
	Mnt_W = W;

  difference() {
    union() {
      // Create front
      translate([0, 0, 0])
        cube([Mnt_T, Mnt_W+Mnt_T*2, Mnt_H]);

      //minkowskiRound(2,2,1,[10,10,10])
        //union() {
          // Create rear
          translate([L-Mnt_T/2, 0, 0])
            cube([Mnt_T, Mnt_W+Mnt_T*2, h+T]);
       
          // Screw post
          translate([L+Mnt_T+Slop, W/2+Mnt_T, 0])
            tube(h=h+T, id=Screw, od=Screw*3);
        //}
    }
    // Remove USB slot
    translate([-0.01, Mnt_T+Mnt_W*0.25, h])
      cube([Mnt_T*2, W*0.5, T*2]);
    
    // Remove PCB section
    translate([Mnt_T/2-Slop, Mnt_T-Slop, h])
      cube([L+Mnt_T*4, Mnt_W+Slop*2, T+Slop]);;
  }  
}