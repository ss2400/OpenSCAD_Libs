// mbox.scad - Custom box in OpenSCAD

include <NopSCADlib/core.scad>

Color1 = "BurlyWood";
Color2 = "SlateGray";

function mbox(name, thick, vent, vent_w, filet, tolerance, size)
    = concat([name, thick, vent, vent_w, filet, tolerance], size);

function mbox_name(type)       = type[0]; //! Name to allow more than one box in a project
function mbox_thick(type)      = type[1]; //! Panel thickness
function mbox_vent(type)       = type[2]; //! Decorations to ventilation holes [0:No, 1:Yes]
function mbox_ventW(type)      = type[3]; //! Holes width (in mm)  
function mbox_filet(type)      = type[4]; //! Filet diameter
function mbox_tolerance(type)  = type[5]; //! Internal corner radius
function mbox_length(type)     = type[6]; //! Box length
function mbox_width(type)      = type[7]; //! Box width
function mbox_height(type)     = type[8]; //! Box height

// Round box
module RoundBox($a=undef, $b=undef, $c=undef, type) {
  Length = mbox_length(type);
  Filet = mbox_filet(type);
  $fn=50;
  
  translate([0,Filet,Filet]){  
    minkowski (){          
      cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
      rotate([0,90,0]){    
        cylinder(r=Filet,h=Length/2, center = false);
      } 
    }
  }
}
      
// Shell
module mbox_shell(type) {
  Thick = mbox_thick(type)*2;
  Length = mbox_length(type);
  Width = mbox_width(type);
  Height = mbox_height(type);
  Vent = mbox_vent(type);
  Vent_width = mbox_ventW(type);
  Filet = mbox_filet(type);
  m = mbox_tolerance(type);
  
  Dec_Thick = Vent ? Thick*2 : Thick; // Thick X 2 - make sure they go through shell
  Dec_size  = Vent ? Thick*2 : 0.8; // Depth decoration
  
  difference(){    
    difference(){//sides decoration
      union(){    
        difference() {// Subtraction Filleted box
    
          difference(){// Median cube slicer
            union() {// Union               
              difference(){//S hell    
                RoundBox($a=Length, $b=Width, $c=Height, type=type);
                translate([Thick/2,Thick/2,Thick/2]){     
                  RoundBox($a=Length-Thick, $b=Width-Thick, $c=Height-Thick, type=type);
                }
              }//End diff Shell          
              difference(){//larger Rails        
                translate([Thick+m,Thick/2,Thick/2]){// Rails
                  RoundBox($a=Length-((2*Thick)+(2*m)), $b=Width-Thick, $c=Height-(Thick*2), type=type);
                }//End Rails
                translate([((Thick+m/2)*1.55),Thick/2,Thick/2+0.1]){ // +0.1 added to avoid the artifact
                  RoundBox($a=Length-((Thick*3)+2*m), $b=Width-Thick, $c=Height-Thick, type=type);
                }           
              }//End larger Rails
            }//End union                 
            translate([-Thick,-Thick,Height/2]){
              cube ([Length+100, Width+100, Height], center=false);
            }        
          }// End Median cube slicer
          translate([-Thick/2,Thick,Thick]){
            RoundBox($a=Length+Thick, $b=Width-Thick*2, $c=Height-Thick, type=type);       
          }        
        }      

        difference(){// Fixation box legs
          union(){
            translate([3*Thick +5,Thick,Height/2]){
              rotate([90,0,0]){
                $fn=6;
                cylinder(d=16,Thick/2);
              }   
            }

            translate([Length-((3*Thick)+5),Thick,Height/2]){
              rotate([90,0,0]){
                $fn=6;
                cylinder(d=16,Thick/2);
              }   
            }

          }
          translate([4,Thick+Filet,Height/2-57]){   
            rotate([45,0,0]){
              cube([Length,40,40]);    
            }
          }
          translate([0,-(Thick*1.46),Height/2]){
            cube([Length,Thick*2,10]);
          }
        } //End fixation box legs
      }

      union(){// outbox sides decorations
        //if(Thick==1){Thick=2;
        for(i=[0:Thick:Length/4]){

          // Ventilation holes part code submitted by Ettie - Thanks ;) 
          translate([10+i,-Dec_Thick+Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([(Length-10) - i,Width-Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([10+i,Width-Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
                  
        }// End for
               // }
      }//End union decoration
    }//End difference decoration

    union(){ //sides holes
      $fn=50;
      translate([3*Thick+5,20,Height/2+4]){
        rotate([90,0,0]){
          cylinder(d=2,20);
        }
      }
      translate([Length-((3*Thick)+5),20,Height/2+4]){
        rotate([90,0,0]){
          cylinder(d=2,20);
        }
      }
      translate([3*Thick+5,Width+5,Height/2-4]){
        rotate([90,0,0]){
          cylinder(d=2,20);
        }
      }
      translate([Length-((3*Thick)+5),Width+5,Height/2-4]){
        rotate([90,0,0]){
          cylinder(d=2,20);
        }
      }
    }//End sides holes

  }//End difference holes
}

// Panels
module mbox_panels(type){
  Thick = mbox_thick(type);
  Length = mbox_length(type);
  Width = mbox_width(type);
  Height = mbox_height(type);
  m = mbox_tolerance(type);
  
  color(Color2){
    translate([Thick+m,m/2,m/2]){
      difference(){
        translate([0,Thick,Thick]){
          RoundBox(Length,Width-((Thick*2)+m),Height-((Thick*2)+m), type=type);}
        translate([Thick,-5,0]){
          cube([Length,Width+10,Height]);}
      }
    }
  }
}

// Back Panel
module mbox_bpanel(type){
  stl(str(mbox_name(type),"_bpanel"));
  m = mbox_tolerance(type);
  
  difference(){
    union(){
      color(Color2)
        translate ([-m/2,0,0])
          mbox_panels(type);

      if($children > 0)
        children(0);
    }
    if($children > 1)
      children(1);
  }
}

// Front Panel
module mbox_fpanel(type){
  stl(str(mbox_name(type),"_fpanel"));
  Length = mbox_length(type);
  Width = mbox_width(type);
  m = mbox_tolerance(type);
  
  difference(){
    union(){
      color(Color2)
        rotate([0,0,180])
          translate([-Length-m/2,-Width,0])
            mbox_panels(type);

      if($children > 0)
        children(0);
    }
    if($children > 1)
      children(1);
  }
}

// Bottom shell
module mbox_bshell(type){
  m = mbox_tolerance(type);
  stl(str(mbox_name(type),"_bshell"));
  
  difference(){
    union(){
      color(Color1)
        mbox_shell(type);

      if($children > 0)
        children(0);
    }
    if($children > 1)
      children(1);
  }
}

// Top Shell
module mbox_tshell(type){
  stl(str(mbox_name(type),"_tshell"));
  Width = mbox_width(type);
  Height = mbox_height(type);
  m = mbox_tolerance(type);
  
  difference(){
    union(){
      color(Color1)
        translate([0,Width,Height+0.2])
          rotate([0,180,180])
            mbox_shell(type);

      if($children > 0)
        children(0);
    }
    if($children > 1)
      children(1);
  }
}
