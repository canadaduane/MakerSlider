$fn=64;
fudge_r = 0.3;
nudge = 0.01;
long=100;

bolt_head_inner_r = 11/2;
bolt_head_r = 12.67/2 + fudge_r;
bolt_head_d = 8.0;
bolt_flange_r = 15.5/2 + fudge_r;
bolt_flange_d = 2.0;
bolt_flange_extra_d = 1.0;
bolt_flange_space_d = 5.5;
bolt_d = bolt_head_d + bolt_flange_d;

// size of bolts that mount the plastic to the slider
mount_head_d = 3.6;
mount_head_r = 9.3/2+fudge_r;
mount_hole_r = 2.5+fudge_r;
mount_hole_support_r = 6.0;

mount_r = 16.5;
mount_d = bolt_d + mount_head_d;

// distance of makerslide slot from center of makerslide (2 slots)
slot_dist_adj = 10.0;
slot_dist_r = sqrt(slot_dist_adj*slot_dist_adj*2);

difference() {
  union() {
    // scale([1,1,mount_d])
      // import("tripod-mount-x.stl", convexity=6);
    rotate([0, 0, 15])
      cylinder(r=mount_r, h=mount_d, $fn=6);
    
    rotate([0,0,45])
      for(theta=[0, 90, 180, 270])
        translate([cos(theta)*slot_dist_r, sin(theta)*slot_dist_r])
          cylinder(r=mount_hole_support_r, h=mount_d - mount_head_d);
  }

  translate([0,0,-nudge])
    cylinder(r=bolt_flange_r, h=mount_head_d-bolt_flange_extra_d+nudge*2+bolt_flange_space_d);

  translate([0,0,mount_d - bolt_d - bolt_flange_extra_d + bolt_flange_space_d])
    cylinder(r1=bolt_flange_r, r2=bolt_head_inner_r, h=bolt_flange_d+bolt_flange_extra_d);

  rotate([0, 0, 15])
    cylinder(r=bolt_head_r, h=long, $fn=6, center=true);

  rotate([0,0,45])
    for(theta=[0, 90, 180, 270])
      translate([cos(theta)*slot_dist_r, sin(theta)*slot_dist_r]) {
        cylinder(r=mount_hole_r, h=long, center=true);
        translate([0,0,mount_d-mount_head_d+nudge])
          cylinder(r=mount_head_r, h=mount_head_d);
      }
}