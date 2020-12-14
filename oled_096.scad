// oled_096.scad - OLED 0.96" screen in OpenSCAD
$fn = 36;

include <OpenSCAD_Libs/models/096OledDim.scad>; // OLED screen dimensions
use <OpenSCAD_Libs/models/096Oled.scad>; // OLED screen model

post_slop = 0.6;  // Additional tolerance for posts
glass_slop = 1.0; // Additional tolerance for glass
face = 3.0;       // Face plate thickness

// OLED cutout for difference
module oled_cutout() {
  // Cutout volume over the view area
  DisplayLocalize(type=I2C4, align=0, dalign=1)
    translate([0,0,6.0/2])
      cube([I2C4_LVW,I2C4_LVL,6.0], center=true);

  // Over the module glass... (Increased by slop)
  DisplayLocalize(type=I2C4, align=1, dalign=2)
    translate([0,0,(I2C4_LH+0.1)/2])
      cube([I2C4_LGW+glass_slop, I2C4_LGL+glass_slop, I2C4_LH], center=true);

  // Internal flat cable
  DisplayLocalize(type=I2C4, align=4, dalign=1)
    translate([0,0,I2C4_LH/2])
      cube([I2C4_PCW,I2C4_PL-I2C4_LGL-I2C4_LGLO,I2C4_LH], center=true);

  // Connector cutout (glass side)
  DisplayLocalize(type=I2C4, align=2, dalign=1)
    translate([0, I2C4_PL/2-I2C4_CYO, I2C4_SSH/2])
      cube([I2C4_CFW, I2C4_CFL, I2C4_SSH], center=true);
}

// Posts (Reduced by slop)
module oled_posts() {
  for (i=[0:1:len(HOLES[I2C4])-1])
    hull() {
      for (j=[0:1:len(HOLES[I2C4][i])-1])
        translate([HOLES[I2C4][i][j][1][0], HOLES[I2C4][i][j][1][1], -0.4])
          cylinder(d=HOLES[I2C4][i][j][0]-post_slop, h=PCB[I2C4][0][2]+1.5, center=true);
    }
}

// Examples
difference() {
  // Faceplate
  translate([0,0,2.2])
    cube([35,35,face], center=true);

  oled_cutout();
}
// Posts
oled_posts();

// --- I2C4 ---
DisplayModule(type=I2C4, align=1, G_COLORS=true);
