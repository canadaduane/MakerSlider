include <scad/tapercube.scad>;

long=100;

r_fudge = 0.3;

// idler_dist_between_holes = 28.0;
idler_dist_between_holes = 34.0;

plate_width = 90.0;
plate_mount_hole_r = 2.5 + r_fudge;
plate_mount_dist_hole_x = 64;
plate_mount_dist_hole_y = 20;

motor_width = 42.25;
gap_width = 3.0;

motor_dist_between_mount_holes = 31;
motor_mount_hole_r = 1.75 + r_fudge;
motor_axle_hole_r = 4 + r_fudge;
motor_ring_r = 11.0 + r_fudge;
motor_ring_depth = 2.0;

subplate_width = plate_width + gap_width + motor_width;
subplate_height = motor_width;
subplate_depth = 5.0;
// subplate_depth = 0.4;

mount_hole_center_x = motor_width + gap_width + plate_width/2 - plate_mount_dist_hole_x/2;

$fn = 48;

module motor_mount_holes() {
  d = motor_dist_between_mount_holes;
  r = sqrt(d*d*2)/2;
  for (theta=[45,135,225,315])
    translate([cos(theta)*r, sin(theta)*r])
      cylinder(r=motor_mount_hole_r, h=long, center=true);
}

module plate_mount_holes() {
  x = plate_mount_dist_hole_x;
  for (y=[0,plate_mount_dist_hole_y])
    translate([x, y, 0])
      cylinder(r=plate_mount_hole_r, h=long, center=true);

  translate([0, plate_mount_dist_hole_y/2, 0])
    cylinder(r=plate_mount_hole_r, h=long, center=true);
}

module idler_mount_holes() {
  for (y=[0,idler_dist_between_holes])
    translate([0, y, 0])
      cylinder(r=plate_mount_hole_r, h=long, center=true);
}

module subplate() {
  idler_extra_width = 25;
  idler_extra_height = 16;

  difference() {
    // cube([subplate_width, subplate_height, subplate_depth]);
    union() {
      cornerless_cube(subplate_width, subplate_height, subplate_depth, 8.0);
      translate([mount_hole_center_x-(idler_extra_width/2), -(idler_extra_height/2), 0])
        cornerless_cube(idler_extra_width, subplate_height + idler_extra_height, subplate_depth, 8.0);
    }

    translate([motor_width/2, motor_width/2, 0]) {
      motor_mount_holes();
      cylinder(r=motor_axle_hole_r, h=long, center=true);

      translate([0,0, subplate_depth - motor_ring_depth+0.1])
        cylinder(r=motor_ring_r, h=motor_ring_depth);
    }

    translate([mount_hole_center_x, 0, 0]) {
      translate([0, motor_width/2 - plate_mount_dist_hole_y/2, 0])
        plate_mount_holes();
      translate([0, motor_width/2 - idler_dist_between_holes/2, 0])
        idler_mount_holes();
    }
  }
}

subplate();