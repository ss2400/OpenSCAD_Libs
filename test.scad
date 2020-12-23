use <OpenSCAD_Libs/mbox.scad>

length = 80;
width = 45;
height = 40;

box1 = mbox(name="box1", panel_t=2, shell_t=3, vent=0, vent_w=1.5, filet=2, tolerance=0.9, size=[length, width, height]);

module box1_case_stl() {
  mbox_bpanel(box1) {
    //box1_internal_additions();
    //box1_holes();
    //box1_external_additions();
  };
     
  mbox_fpanel(box1) {
    //box1_internal_additions();
    //box1_holes();
    //box1_external_additions();
  };
 
  mbox_bshell(box1) {
    //box1_internal_additions();
    //box1_holes();
    //box1_external_additions();
  };
  
  mbox_tshell(box1) {
    //box1_internal_additions();
    //box1_holes();
    //box1_external_additions();
  };
}

echo(mbox_name(box1));
echo(mbox_panel(box1));
echo(mbox_shell(box1));
echo(mbox_vent(box1));
echo(mbox_ventW(box1));
echo(mbox_filet(box1));
echo(mbox_tolerance(box1));
echo(mbox_length(box1));
echo(mbox_width(box1));
echo(mbox_height(box1));

box1_case_stl();