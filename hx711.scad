// hx711.scad - HX711 Mount in OpenSCAD
$fn=100;

Slop = 0.1;     // Fitment slop

// PCB parameters
L = 33.6;       // PCB Length
W = 20.5;       // PCB Width
T = 1.6;        // PCB Thickness
Hole = 3;       // Hole size
Offset1 = 4.4;  // Hole offset from edge
Offset2 = 2.4;  // Hole offset from edge

// Examples
hx711(h);
hx711_mount(h=5);

module hx711(h=5) {
    
    translate([0, Mnt_T/2, 0]) {
        difference() {
            // PCB
            translate([0, 0, h])
                %cube([L, W, T]);

            // Holes
            translate([L-Offset1, W-Offset2, h+T/2])
                %cylinder(h = 2*T, d = Hole, center = true);
            translate([L-Offset1, Offset2, h+T/2])
                %cylinder(h = 2*T, d = Hole, center = true);
        }
    }
}

module hx711_mount(h=5) {
	// Mount parameters
	Mnt_Lip = 3;
	Mnt_H = h + T + 1;
	Mnt_L = L + Mnt_Lip/2;
	Mnt_W = W;
	Mnt_T = 2; 
	
    difference() {
        union() {
        // Create 1st side
        translate([0, Mnt_W, 0])
            cube([Mnt_L, Mnt_T, Mnt_H]);
        // Create 2nd side    
        translate([0, 0, 0])
            cube([Mnt_L, Mnt_T, Mnt_H]);
        }
        
        // Remove PCB slot
        translate([-Slop, Mnt_T/2-Slop, h-Slop])
            cube([L+2*Slop, W+2*Slop, T+2*Slop]);
        
        // Remove section above PCB
        translate([Mnt_Lip, Mnt_T/2-Slop, h])
            cube([Mnt_L-2*Mnt_Lip+Slop, W+2*Slop, 3*T]);;
        
        // Remove any overhang
        translate([-10, -1, -1])
            cube([10, Mnt_W+Mnt_T+2, Mnt_H+2]);
        
    }
}
