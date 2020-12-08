// oled_096.scad - OLED 0.96" screen in OpenSCAD
//$fn=100;

include <OpenSCAD_Libs/models/096OledDim.scad>;              // OLED screen dimensions
use <OpenSCAD_Libs/models/096Oled.scad>;                     // OLED screen model

// --- CRIUS ---
// Align the glass side of the PCB under the XY plane (align=1)
DisplayModule(type=I2C4, align=1, G_COLORS=true);

// Localize a cutout volume over the view area
DisplayLocalize(type=I2C4, align=0, dalign=1)
    translate([0,0,6.0/2])
        #cube([I2C4_LVW,I2C4_LVL,6.0], center=true);
// ... another one over the module glass...
DisplayLocalize(type=I2C4, align=1, dalign=2)
    translate([0,0,(I2C4_LH+5.0)/2])
        #cube([I2C4_LGW+0.2, I2C4_LGL+0.2, I2C4_LH+5.0], center=true);
// ... and the last one to cutout a volume for the OLED's internal flat cable
DisplayLocalize(type=I2C4, align=4, dalign=1)
    translate([0,0,OLED[I2C4][0][2]/2])
        #cube([I2C4_PCW,I2C4_PL-I2C4_LGL-I2C4_LGLO,I2C4_LH], center=true);

//DisplayLocalize(type=CRIUS, align=0, dalign=1);
//DisplayLocalize(type=CRIUS, align=1, dalign=2);
//DisplayLocalize(type=CRIUS, align=4, dalign=1);

//DisplayModule(type=I2CSPI7, align=0, G_COLORS=true);
//DisplayModule(type=I2CSPI7, align=1, G_COLORS=true);
//DisplayModule(type=I2CSPI7, align=2, G_COLORS=true);

//DisplayModule(type=I2C4, align=0, G_COLORS=true);
//DisplayModule(type=I2C4, align=1, G_COLORS=true);
//DisplayModule(type=I2C4, align=2, G_COLORS=true);


//OLEDDemo();
