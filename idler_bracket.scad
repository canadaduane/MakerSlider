include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

bolt_r = 3.0+fudge;
bolt_head_r = 4.5+fudge;
bolt_head_seat = 2.5;

bearing_r = 8.0+fudge;
bearing_th = 6.0+fudge;

makerslide_w = 20.0;
makerslide_deck = 7.25;

ms_arm_th = 7.5;
ms_arm_w = 15.0;
ms_arm_l = 25.0;
ms_arm_between = 12.0;
slot_depth = 15.0;
slot_w = 5;

taper = 5.0;

module bearing_bracket() {

}

module makerslide_bracket() {
  difference() {
    union() {
      // lower arm connected to makerslide
      cornerless_cube(ms_arm_l, ms_arm_w, ms_arm_th, taper);
      
      // connect the lower arm to upper arm
      hull() {
        translate([ms_arm_l - ms_arm_w, 0])
          cornerless_cube(ms_arm_w, ms_arm_w, ms_arm_th, taper);

        translate([ms_arm_l, makerslide_deck])
          cornerless_cube(ms_arm_w, ms_arm_w, ms_arm_th, taper);
      }

      // upper arm ready to receive bearing_bracket
      translate([ms_arm_l, makerslide_deck]) {
        difference() {
          cornerless_cube(ms_arm_l, ms_arm_w, ms_arm_th, taper);
        // translate([taper, 0, ms_arm_th]) {
        //   difference() {
        //     cornerless_cube(ms_arm_l - taper, ms_arm_w, ms_arm_th, taper);
        //     translate([ms_arm_l-taper-sqrt(taper), 0])
        //       cube([ms_arm_w, ms_arm_w, ms_arm_th+shim]);
          translate([taper, ms_arm_w/2-slot_w/2, -shim])
            cube([ms_arm_l, slot_w, ms_arm_th+shim*2]);
        }
      }
    }

    translate([0, ms_arm_w, -shim])
      cube(ms_arm_l, ms_arm_w, ms_arm_th+shim*2);

    translate([0, ms_arm_w/2, -long/2]) {
      translate([ms_arm_l/2 - ms_arm_between/2, 0]) {
        cylinder(r=bolt_r, h=long, $fn=48);
        // translate([0, 0, long/2-5+bolt_head_seat])
          // cylinder(r=bolt_head_r, h=5, $fn=48);
      }
      translate([ms_arm_l/2 + ms_arm_between/2, 0]) {
        cylinder(r=bolt_r, h=long, $fn=48);
        // translate([0, 0, long/2-5+bolt_head_seat])
          // cylinder(r=bolt_head_r, h=5, $fn=48);
      }
    }

  }
}
// idler_bracket();
makerslide_bracket();
// translate([0, 50, 0])
//   scale([1, -1, 1])
//     makerslide_bracket();
