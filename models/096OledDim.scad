// 0.96" OLED Dimensions
// V1.1 - 17/03/2017
// DonJuanito - Juan Manuel FERNANDEZ CASTRO

CRIUS = 0;      // CRIUS display
I2CSPI7 = 1;    // I2C/SPI 7 pins display
I2C4 = 2;       // I2C 4 pins display

/*
If you want to use the OLED model 'genderless' dimensions in your
project, you can use the following table find the dimensions names:

Example for CRIUS model ('type' contains one of the values defined
in the previous lines [0 - 2]):

Replace:    By:

CRIUS_PW	PCB[type][0][0]
CRIUS_PL	PCB[type][0][1]
CRIUS_PH	PCB[type][0][2]
CRIUS_PCW	PCB[type][2][0]
CRIUS_PCL	PCB[type][2][1]
CRIUS_PCOR	PCB[type][3]
CRIUS_LGW	OLED[type][0][0]
CRIUS_LGL  	OLED[type][0][1]
CRIUS_LH	OLED[type][0][2]
CRIUS_LGLO	OLED[type][2]
CRIUS_LDW 	OLED[type][1][0]
CRIUS_LDL 	OLED[type][1][1]
CRIUS_LVW	OLED[type][3][0]
CRIUS_LVL	OLED[type][3][1]
CRIUS_CFW	BS[type][0][0]
CRIUS_CFL	BS[type][0][1]
CRIUS_CFH	BS[type][0][2]
CRIUS_SSH	BS[type][1]
CRIUS_CYO	BS[type][2]
*/

// --- CRIUS OLED ---
// PCB
CRIUS_PW = 26.6;        // PCB width (X)
CRIUS_PL = 26.6;        // PCB length (Y)
CRIUS_PH = 0.8;         // PCB height (without components) (Z)
CRIUS_PCW = 15.5;       // PCB Y cutout window(s) width
CRIUS_PCL = 1.0;        // PCB Y cutout window(s) length
CRIUS_PCOR = 0.0;       // PCB corner radius
// OLED
CRIUS_LH = 1.8;         // OLED glass height (Z)
CRIUS_LGW = CRIUS_PW;   // OLED glass width (X)
CRIUS_LGL = 19.2;       // OLED glass length (Y)
CRIUS_LGLO = 4.6;       // OLED glass length offset (-Y)
CRIUS_LDW = CRIUS_LGW;  // OLED display zone width (X)
CRIUS_LDL = 14.6;       // OLED display zone length (Y)
CRIUS_LVW = 21.8;       // OLED view area width (X)
CRIUS_LVL = 11.4;       // OLED view area length (Y)
// Bottom side components
CRIUS_CFW = 9.8;        // Connector Width (X)
CRIUS_CFL = 4.2;        // Connector Length (Y)
CRIUS_CFH = 3.8;        // Connector Height (Z)
CRIUS_CYO = 0.2 + CRIUS_CFL/2 + CRIUS_PCL;  // Connector Y offset (from PCB Y+ border / top)
//CRIUS_CFO = 1.6;
CRIUS_SSH = 0;          // Solder side (glass side) height
// Texts
CRIUS_TXT = [
                "CRIUS"
            ];
CRIUS_TXT_POS = [
                    [ 0, CRIUS_PL/2-CRIUS_PCL-1.8, (CRIUS_PH+0.001)/2 ]
            ];
CRIUS_TXT_FONT = [
                "Arial:style=Bold"
            ];
CRIUS_TXT_SIZ = [
                2
            ];
CRIUS_TXT_HALIGN = [
                "center"
            ];
CRIUS_TXT_VALIGN = [
                "center"
            ];
CRIUS_HOLES = [
//           [Dia, [Pos X,  Pos Y (from PCB center)], ...]
//           Grouped by a 'hull' function
    ];
// Colors
CRIUS_COLORS = [
            "Green",        // 0: PCB
            "DimGray",      // 1: LCD base
            "DarkSlateGray",// 2: Display window
            "DarkMagenta",  // 3: Viewarea
            "OldLace"       // 4: Connector
         ];

// --- I2C/SPI 7 pins display ---
// PCB
I2CSPI7_PW = 27.6;          // PCB width (X)
I2CSPI7_PL = 28.0;          // PCB length (Y)
I2CSPI7_PH = 1.2;           // PCB height (without components) (Z)
I2CSPI7_PCW = 13.4;         // PCB Y cutout window(s) width
I2CSPI7_PCL = 1.2;          // PCB Y cutout window(s) length
I2CSPI7_PCOR = 1.0;         // PCB corner radius
// OLED
I2CSPI7_LH = 1.6;           // OLED glass height (Z)
I2CSPI7_LGW = I2CSPI7_PW;   // OLED glass width (X)
I2CSPI7_LGL = 19.3;         // OLED glass length (Y)
I2CSPI7_LGLO = 4.5;         // OLED glass length offset (-Y)
I2CSPI7_LDW = I2CSPI7_LGW;  // OLED display zone width (X)
I2CSPI7_LDL = 15.2;         // OLED display zone length (Y)
I2CSPI7_LVW = 21.8;         // OLED view area width (X)
I2CSPI7_LVL = 11.4;         // OLED view area length (Y)
// Bottom side components
I2CSPI7_CFW = 12.0;         // Connector Width (X)
I2CSPI7_CFL = 2.54;         // Connector Length (Y)
I2CSPI7_CFH = 8.0;          // Connector Height (Z)
I2CSPI7_CYO = 0.4 + I2CSPI7_CFL/2;  // Connector Y offset (from PCB Y+ border / top)
I2CSPI7_SSH = 2.2;      // Solder side (glass side) height
// Text (top side)
I2CSPI7_TXT = [
            ];
I2CSPI7_TXT_POS = [
            ];
I2CSPI7_TXT_FONT = [
            ];
I2CSPI7_TXT_SIZ = [
            ];
I2CSPI7_TXT_HALIGN = [
            ];
I2CSPI7_TXT_VALIGN = [
            ];
// Holes
I2CSPI7_HOLES = [
//           [Dia, [Pos X,  Pos Y (from PCB center)], ...]
//           Grouped by a 'hull' function
        // Top Left
        [
            [1.8, [ -11.9, 12.2]]
        ],
        // Top Right
        [
            [1.8, [ 11.9, 12.2]]
        ],
        // Bottom Left
        [
            [1.8, [ -11.9, -12.2]]
        ],
        // Bottom Right
        [
            [1.8, [ 11.9, -12.2]]
        ]
    ];
// Colors
I2CSPI7_COLORS = [
            "SteelBlue",    // 0: PCB
            "DimGray",      // 1: LCD base
            "DarkSlateGray",// 2: Display window
            "DarkMagenta",  // 3: Viewarea
            "Gray"          // 4: Connector
         ];

// --- I2C 4 pins display ---
// PCB
I2C4_PW = 27.0;             // PCB width (X)
I2C4_PL = 27.3;             // PCB length (Y)
I2C4_PH = 1.0;              // PCB height (without components) (Z)
I2C4_PCW = 15.1;            // PCB Y cutout window(s) width
I2C4_PCL = 1.4;             // PCB Y cutout window(s) length
I2C4_PCOR = 1.0;            // PCB corner radius
// OLED
I2C4_LH = 1.8;              // OLED glass height (Z)
I2C4_LGW = I2C4_PW;         // OLED glass width (X)
I2C4_LGL = 19.2;            // OLED glass length (Y)
I2C4_LGLO = 4.0;            // OLED glass length offset (-Y)
I2C4_LDW = I2C4_LGW;        // OLED display zone width (X)
I2C4_LDL = 14.8;            // OLED display zone length (Y)
I2C4_LVW = 21.8;            // OLED view area width (X)    
I2C4_LVL = 11.4;            // OLED view area length (Y)
// Bottom side components
I2C4_CFW = 10.2;            // Connector Width (X)
I2C4_CFL = 2.54;            // Connector Length (Y)
I2C4_CFH = 8.4;             // Connector Height (Z)
I2C4_CYO = 0.4 + I2C4_CFL/2;  // Connector Y offset (from PCB Y+ border / top)
I2C4_SSH = 2.0;      // Solder side (glass side) height
// Text (top side)
I2C4_TXT = [
            ];
I2C4_TXT_POS = [
            ];
I2C4_TXT_FONT = [
            ];
I2C4_TXT_SIZ = [
            ];
I2C4_TXT_HALIGN = [
            ];
I2C4_TXT_VALIGN = [
            ];
// Holes
I2C4_HOLES = [
//           [Dia, [Pos X,  Pos Y (from PCB center)], ...]
//           Grouped by a 'hull' function
        // Top Left
        [
            [2.2, [ -10.6, 11.6]],
            [2.2, [ -9.6, 11.6]],
        ],
        // Top Right
        [
            [2.2, [ 10.6, 11.6]],
            [2.2, [ 9.6, 11.6]],
        ],
        // Bottom Left
        [
            [2.2, [ -10.6, -11.6]],
            [2.2, [ -9.6, -11.6]],
        ],
        // Bottom Right
        [
            [2.2, [ 10.6, -11.6]],
            [2.2, [ 9.6, -11.6]],
        ]
    ];
/*
        // Top Left
        [
            [2.2, [ -10.4, 11.6]],
            [2.2, [ -9.4, 11.6]],
        ],
        // Top Right
        [
            [2.2, [ 10.4, 11.6]],
            [2.2, [ 9.4, 11.6]],
        ],
        // Bottom Left
        [
            [2.2, [ -10.4, -11.6]],
            [2.2, [ -9.4, -11.6]],
        ],
        // Bottom Right
        [
            [2.2, [ 10.4, -11.6]],
            [2.2, [ 9.4, -11.6]],
        ]
    ];
*/
// Colors
I2C4_COLORS = [
            "SteelBlue",    // 0: PCB
            "DimGray",      // 1: LCD base
            "DarkSlateGray",// 2: Display window
            "DarkMagenta",  // 3: Viewarea
            "Gray"          // 4: Connector
         ];

// ---------------------------------------------------------------
// --- INTERNAL, DO NOT CHANGE FROM HERE -------------------------
// ---------------------------------------------------------------

PCB = [
        // CRIUS
        [
            [ CRIUS_PW, CRIUS_PL, CRIUS_PH ],
            1,  // 0=No cutouts, 1=Y- cutout, 2=Y+ and Y- cutout
            [CRIUS_PCW, CRIUS_PCL],
            CRIUS_PCOR
        ],
        // I2CSPI7
        [
            [ I2CSPI7_PW, I2CSPI7_PL, I2CSPI7_PH ],
            0,  // 0=No cutouts, 1=Y- cutout, 2=Y+ and Y- cutout
            [I2CSPI7_PCW, I2CSPI7_PCL],
            I2CSPI7_PCOR
        ],
        // I2C4
        [
            [ I2C4_PW, I2C4_PL, I2C4_PH ],
            0,  // 0=No cutouts, 1=Y- cutout, 2=Y+ and Y- cutout
            [I2C4_PCW, I2C4_PCL],
            I2C4_PCOR
        ]
      ];

OLED = [
        // CRIUS
        [
            [ CRIUS_LGW, CRIUS_LGL, CRIUS_LH ],
            [ CRIUS_LDW, CRIUS_LDL ],
            CRIUS_LGLO,
            [ CRIUS_LVW, CRIUS_LVL ]
        ],
        // I2CSPI7
        [
            [ I2CSPI7_LGW, I2CSPI7_LGL, I2CSPI7_LH ],
            [ I2CSPI7_LDW, I2CSPI7_LDL ],
            I2CSPI7_LGLO,
            [ I2CSPI7_LVW, I2CSPI7_LVL ]
        ],
        // I2C4
        [
            [ I2C4_LGW, I2C4_LGL, I2C4_LH ],
            [ I2C4_LDW, I2C4_LDL ],
            I2C4_LGLO,
            [ I2C4_LVW, I2C4_LVL ]
        ]
       ];
BS = [
        // CRIUS
        [
            [CRIUS_CFW, CRIUS_CFL, CRIUS_CFH ],
            CRIUS_SSH,
            CRIUS_CYO
        ],
        // I2CSPI7
        [
            [I2CSPI7_CFW, I2CSPI7_CFL, I2CSPI7_CFH ],
            I2CSPI7_SSH,
            I2CSPI7_CYO
        ],
        // I2C4
        [
            [I2C4_CFW, I2C4_CFL, I2C4_CFH ],
            I2C4_SSH,
            I2C4_CYO
        ]
     ];
TEXTS = [
            // CRIUS
            [
                CRIUS_TXT,
                CRIUS_TXT_POS,
                CRIUS_TXT_FONT,
                CRIUS_TXT_SIZ,
                CRIUS_TXT_HALIGN,
                CRIUS_TXT_VALIGN
            ],
            // I2CSPI7
            [
                I2CSPI7_TXT,
                I2CSPI7_TXT_POS,
                I2CSPI7_TXT_FONT,
                I2CSPI7_TXT_SIZ,
                I2CSPI7_TXT_HALIGN,
                I2CSPI7_TXT_VALIGN
            ],
            // I2C4
            [
                I2C4_TXT,
                I2C4_TXT_POS,
                I2C4_TXT_FONT,
                I2C4_TXT_SIZ,
                I2C4_TXT_HALIGN,
                I2C4_TXT_VALIGN
            ]
        ];
COLORS = [
            // CRIUS
            CRIUS_COLORS,
            // I2CSPI7
            I2CSPI7_COLORS,
            // I2C4
            I2C4_COLORS
         ];
HOLES = [
            // CRIUS
            CRIUS_HOLES,
            // I2CSPI7
            I2CSPI7_HOLES,
            // I2C4
            I2C4_HOLES
        ];
