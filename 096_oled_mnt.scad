// 096oled_mnt.scad - OLED 0.96" screen in OpenSCAD
$fn = 36;

include <OpenSCAD_Libs/models/096OledDim.scad>; // OLED screen dimensions
use <OpenSCAD_Libs/models/096Oled.scad>; // OLED screen model

post_slop = 0.6;  // Additional tolerance for posts
glass_slop = 1.0; // Additional tolerance for glass

// Examples
face = 2.4; // Face plate thickness
oled_mount(type=DORHEA)
  translate([-20,-20,0])
    cube([40,40,face], center=false);
DisplayModule(type=DORHEA, align=1, G_COLORS=true);

// OLED cutout
module oled_cutout(type=undef) {
  translate([0,0,-0.1]) {
    union() {
      // Cutout volume over the view area
      DisplayLocalize(type=type, align=0, dalign=1)
        translate([0,0,6.0/2])
          cube([OLED[type][3][0],OLED[type][3][1],6.0], center=true);

      // Over the module glass... (Increased by slop)
      DisplayLocalize(type=type, align=1, dalign=2)
        translate([0,0,(OLED[type][0][2]+0.1)/2])
          cube([OLED[type][0][0]+glass_slop, OLED[type][0][1]+glass_slop, OLED[type][0][2]], center=true);

      // Internal flat cable
      DisplayLocalize(type=type, align=4, dalign=1)
        translate([0,0,OLED[type][0][2]/2])
          cube([PCB[type][2][0],PCB[type][0][1]-OLED[type][0][1]-OLED[type][2],OLED[type][0][2]], center=true);

      // Connector cutout (glass side)
      DisplayLocalize(type=type, align=2, dalign=1)
        translate([0, PCB[type][0][1]/2-BS[type][2], BS[type][1]/2])
          cube([BS[type][0][0], BS[type][0][1], BS[type][1]], center=true);
    }
  }
}

// OLED mounting posts (Reduced by slop)
module oled_posts(type=undef) {
  for (i=[0:1:len(HOLES[type])-1])
    hull() {
      for (j=[0:1:len(HOLES[type][i])-1])
        translate([HOLES[type][i][j][1][0], HOLES[type][i][j][1][1], -0.4])
          cylinder(d=HOLES[type][i][j][0]-post_slop, h=PCB[type][0][2]+2, center=true);
    }
}

// Processing module
module oled_mount(type=undef) {
  difference() {
    children();
    oled_cutout(type=type);
  }
  oled_posts(type=type);
}
