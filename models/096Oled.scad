// 0.96" OLED models
// V1.1 - 17/03/2017
// DonJuanito - Juan Manuel FERNANDEZ CASTRO

// Supported models: (check your module's dimensions as they could be different)
//
// - 0.96" CRIUS
// - 0.96" I2C/SPI 7 pins
// - 0.96" I2C only 4 pins

use <MCAD/boxes.scad>;

// Modules dimensions definitions
// These are defined in a separate file so that can be included and used
// in your main project .scad if needed
include <096OledDim.scad>;

$fn = 36;

// ----------------------------------------------
// --- Demo modules -----------------------------
// ----------------------------------------------

module OLEDDTxt(txt="XXX", txts=3.0) {
    
    translate([0, txts+0.5, 0])
    color("White")
    linear_extrude(height=0.1, center=true, convexity=10)
        text(txt, size=txts, font="Arial:style=Bold", halign="center", valign="top");
}

 module OLEDDPlace(XO=30.0, YO=30.0, n=4) {
    nparts = $children;
    for(i=[0:1:n-1], j=[0:nparts/n])
        if (i+n*j < nparts)
            translate([XO*(i+1), YO*j, 0]) {
                children(i+n*j);
            }
 }

module OLEDDemo() {
    XO = 30.0;
    YO = 36.0;

    // Render ESP base Modules
    translate([-XO/2, YO/2, 0])
    OLEDDPlace(XO=XO, YO=YO, n=2) {
        // CRIUS module
        DisplayModule(type=CRIUS, align=1, G_COLORS=true);
        // I2CSPI7 module
        DisplayModule(type=I2CSPI7, align=1, G_COLORS=true);
        // I2C4 module
        DisplayModule(type=I2C4, align=1, G_COLORS=true);
    }


    // Render ESP Modules Names
    translate([-XO/2, 0, 0])
    OLEDDPlace(XO=XO, YO=YO, n=2) {
        OLEDDTxt(txt="CRIUS");
        OLEDDTxt(txt="I2CSPI7");
        OLEDDTxt(txt="I2C4");
    }
}

// --- Render -----------------------------------
// Only rendered if this SCAD file is opened by itself, not with USE command
OLEDDemo();

// ----------------------------------------------
// --- Usage examples ---------------------------
// ----------------------------------------------

/*
// Include this code in a new SCAD file

use <096Oled.scad>;

// --- CRIUS ---
// Align the glass side of the PCB under the XY plane (align=1)
DisplayModule(type=CRIUS, align=1, G_COLORS=true);

// Localize a cutout volume over the view area
DisplayLocalize(type=CRIUS, align=0, dalign=1)
    translate([0,0,6.0/2])
        #cube([CRIUS_LVW,CRIUS_LVL,6.0], center=true);
// ... another one over the module glass...
DisplayLocalize(type=CRIUS, align=1, dalign=2)
    translate([0,0,(CRIUS_LH+5.0)/2])
        #cube([CRIUS_LGW+0.2, CRIUS_LGL+0.2, CRIUS_LH+5.0], center=true);
// ... and the last one to cutout a volume for the OLED's internal flat cable
DisplayLocalize(type=CRIUS, align=4, dalign=1)
    translate([0,0,OLED[CRIUS][0][2]/2])
        #cube([CRIUS_PCW,CRIUS_PL-CRIUS_LGL-CRIUS_LGLO,CRIUS_LH], center=true);

// --- I2CSPI7 ---
//DisplayModule(type=I2CSPI7, align=0, G_COLORS=true);
//DisplayModule(type=I2CSPI7, align=1, G_COLORS=true);
//DisplayModule(type=I2CSPI7, align=2, G_COLORS=true);

// --- I2C4 ---
//DisplayModule(type=I2C4, align=0, G_COLORS=true);
//DisplayModule(type=I2C4, align=1, G_COLORS=true);
//DisplayModule(type=I2C4, align=2, G_COLORS=true);

*/

// ======================================================
// === MODULES ==========================================
// ======================================================

module DisplayLocalize(type=CRIUS, align=2, dalign=2) {
// Parameters:
// -----------
// type: Display type [0,1,2]
//
// align:  [0 - 4]
// 0: Align on the center of the view area
// 1: Align on the center of the OLED glass
// 2: Align on the center of the Top PCB side
// 3: Align on the center of the Bottom PCB side
// 4: Align on the center of the OLED flat cable
//
// dalign: Display module alignement

VOT = [
        PCB[type][0][2]+OLED[type][0][2],
        OLED[type][0][2],
        0
      ];

VOL = [
        [0, PCB[type][0][1]/2-OLED[type][2]-OLED[type][1][1]/2, 0], //0
        [0, (PCB[type][0][1]-OLED[type][0][1])/2-OLED[type][2], 0], //1
        [0, 0, -OLED[type][0][2]],                                  //2
        [0, 0, -PCB[type][0][2]-OLED[type][0][2]],                  //3
        [0, -(OLED[type][0][1]+OLED[type][2])/2, -OLED[type][0][2]] //4
      ];

    translate(VOL[align]+[0, 0, VOT[dalign]])
        children();
}

module DisplayModule(type=CRIUS, align=2, G_COLORS=true) {
    // align: [0 - 2]
    //  0: Render with bottom side of PCB aligned on the XY plane
    //  1: Render with top side of PCB aligned on the XY plane
    //  2: Render with OLED top aligned on the XY plane

    VOT = [
            PCB[type][0][2]/2,
            -PCB[type][0][2]/2,
            -(PCB[type][0][2]/2+OLED[type][0][2])
          ];

    translate([0, 0, VOT[align]]) {
        // PCB
        color(G_COLORS ? COLORS[type][0]:[])
        difference() {
            // +++
            // PCB
            //roundedCube(PCB[type][0], r=PCB[type][3], sidesonly=true,center=true);
            roundedBox(PCB[type][0], radius=PCB[type][3], sidesonly=true);
            // ---
            // Y borders cutouts
            for (i=[0:1:PCB[type][1]])
            mirror([0,i,0])
            translate([0,-(PCB[type][0][1]-PCB[type][2][1]+0.2)/2,0])
                cube([PCB[type][2][0],PCB[type][2][1]+0.2,PCB[type][0][2]+0.2], center=true);
            // Holes
            for (i=[0:1:len(HOLES[type])-1])
            hull() {
                for (j=[0:1:len(HOLES[type][i])-1])
                    translate([HOLES[type][i][j][1][0], HOLES[type][i][j][1][1], 0])
                        cylinder(d=HOLES[type][i][j][0], h=PCB[type][0][2]+0.2, center=true);
            }

        }
        // OLED
        color(G_COLORS ? COLORS[type][1]:[], G_COLORS ? 0.9:1)
        translate([0,(PCB[type][0][1]-OLED[type][0][1])/2-OLED[type][2],(PCB[type][0][2]+OLED[type][0][2])/2])
            cube(OLED[type][0], center=true);
        color(G_COLORS ? COLORS[type][2]:[], G_COLORS ? 0.9:1)
        translate([0,(PCB[type][0][1]-OLED[type][1][1])/2-OLED[type][2],PCB[type][0][2]/2+OLED[type][0][2]+0.0001/2])
            cube([OLED[type][1][0], OLED[type][1][1], 0.001], center=true);
        color(G_COLORS ? COLORS[type][3]:[], G_COLORS ? 0.9:1)
        translate([0,(PCB[type][0][1]-OLED[type][1][1])/2-OLED[type][2], PCB[type][0][2]/2+OLED[type][0][2]+0.0001])
            cube([OLED[type][3][0], OLED[type][3][1], 0.002], center=true);
        // Bottom side
        rotate([0,180,0]) {
            // Connector (bottom side)
            color(G_COLORS ? COLORS[type][4]:[])
            translate([0,PCB[type][0][1]/2-BS[type][2],(PCB[type][0][2]+BS[type][0][2])/2])
                cube(BS[type][0], center=true);
            // Connector (solder side)
            if (BS[type][1]!=0)
            color(G_COLORS ? COLORS[type][4]:[])
            translate([0,PCB[type][0][1]/2-BS[type][2],-(PCB[type][0][2]+BS[type][1])/2])
                cube([BS[type][0][0], BS[type][0][1], BS[type][1]], center=true);
        }
        // Text
        for (i=[0:1:len(TEXTS[type][0])-1])
        translate(TEXTS[type][1][i])
        linear_extrude(height=0.001,center=true,convexity=10)
            text(TEXTS[type][0][i], size=TEXTS[type][3][i], font=TEXTS[type][2][i], halign=TEXTS[type][4][i], valign=TEXTS[type][5][i]);
    }
}
