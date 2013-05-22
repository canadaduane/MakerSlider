include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

tensioner_bolt_r = 1.75 + fudge;
tensioner_nut_r = 3.15 + fudge;
tensioner_nut_th = 2.4;

bolt_r = 2.9+fudge;
bolt_head_r = 4.9+fudge;
bolt_head_seat = 2.5;

bearing_r = 12.0+fudge;
bearing_th = 6.0+fudge;
bearing_u_th = 10+fudge;
bearing_arm_th = 7.0;
bearing_nut_r = 4.5+fudge;
bearing_nut_th = 3.0;
washer_th = 0.5;

makerslide_w = 40.0;
makerslide_deck = 7.25;

ms_arm_th = 7.5;
ms_arm_w = 15.0;
ms_upper_arm_w = 24.0;
ms_arm_l = 25.0;
ms_arm_between = 12.0;
slot_depth = 15.0;
slot_w = bearing_u_th;

taper = 5.0;

module bearing_bracket() {
  ms_arm_extra = 5.0;
  bar_th = 6.0;
  bar_w = makerslide_w+ms_arm_th*2 + ms_arm_extra;
  block_w = bearing_th*2+washer_th*3 + bearing_arm_th*2;
  block_h = bearing_r*2+bearing_arm_th;

  difference() {
    union() {
      cube([bar_w, bar_th, slot_w-fudge]);
      translate([bar_w/2-block_w/2, 0])
        cornerless_cube(block_w, block_h, bearing_u_th, 3.0);
    }
    translate([bar_w/2-(block_w-bearing_arm_th*2)/2, -shim, -shim])
      cube([(block_w-bearing_arm_th*2), bearing_r*2, bearing_u_th+shim*2]);

    // 5mm bolt hole for bearings
    translate([0, bearing_r, bearing_u_th/2]) {
      rotate([0, 90, 0]) {
        cylinder(r=bolt_r, h=long, $fn=48);
        translate([0, 0, bar_w/2+block_w/2-bearing_nut_th+shim])
          rotate([0, 0, 30])
            cylinder(r=bearing_nut_r, h=bearing_nut_th, $fn=6);
      }
    }

    // 3mm bolt holes for belt tensioners
    // LEFT
    translate([ms_arm_extra/2+ms_arm_th/2, long/2, slot_w/2])
      rotate([90, 0, 0]) {
        cylinder(r=tensioner_bolt_r, long, $fn=48);
        translate([0, 0, long/2-tensioner_nut_th+shim])
          rotate([0, 0, 0])
            cylinder(r=tensioner_nut_r, h=tensioner_nut_th, $fn=6);
      }
    // RIGHT
    translate([bar_w-ms_arm_th/2-ms_arm_extra/2, long/2, slot_w/2])
      rotate([90, 0, 0]) {
        cylinder(r=tensioner_bolt_r, long, $fn=48);
        translate([0, 0, long/2-tensioner_nut_th+shim])
          rotate([0, 0, 0])
            cylinder(r=tensioner_nut_r, h=tensioner_nut_th, $fn=6);
      }
  }
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
          cornerless_cube(ms_upper_arm_w, ms_upper_arm_w, ms_arm_th, taper);
      }

      // upper arm ready to receive bearing_bracket
      translate([ms_arm_l, makerslide_deck])
          cornerless_cube(ms_arm_l, ms_upper_arm_w, ms_arm_th, taper);
    }

    translate([ms_arm_l, makerslide_deck])
      translate([taper*1.5, ms_upper_arm_w/2-slot_w/2, -shim])
        cube([ms_arm_l, slot_w, ms_arm_th+shim*2]);

    // Make room for makerslide v rail
    translate([0, ms_arm_w, -shim])
      cube(ms_arm_l, ms_arm_w, ms_arm_th+shim*2);

    // Bolt holes
    translate([0, ms_arm_w/2, -long/2]) {
      translate([ms_arm_l/2 - ms_arm_between/2, 0]) {
        cylinder(r=bolt_r, h=long, $fn=48);
        translate([0, 0, long/2 + ms_arm_th - bolt_head_seat])
          cylinder(r=bolt_head_r, h=5, $fn=48);
      }
      translate([ms_arm_l/2 + ms_arm_between/2, 0]) {
        cylinder(r=bolt_r, h=long, $fn=48);
        translate([0, 0, long/2 + ms_arm_th - bolt_head_seat])
          cylinder(r=bolt_head_r, h=5, $fn=48);
      }
    }

  }
}

bearing_bracket();

// makerslide_bracket();
// translate([0, 65, 0])
//   scale([1, -1, 1])
//     makerslide_bracket();
