include <scad/tapercube.scad>;

long=100;
r_fudge = 0.3;

around_depth = 8.8;
belt_depth = 7.0;
thickness = 5.0;

adapter_depth = around_depth * 2 + belt_depth + thickness;

motor_width = 42.25;
motor_height = motor_width;
motor_dist_between_mount_holes = 31;
motor_mount_hole_r = 1.75 + r_fudge;
motor_axle_hole_r = 4 + r_fudge;
motor_ring_r = 11.0 + r_fudge;
motor_ring_depth = 2.0;

$fn = 48;

module motor_mount_holes() {
  d = motor_dist_between_mount_holes;
  r = sqrt(d*d*2)/2;
  for (theta=[45,135,225,315])
    translate([cos(theta)*r, sin(theta)*r])
      cylinder(r=motor_mount_hole_r, h=long, center=true);
}

module mount_adapter() {
  iratio = 1.7;
  ibar = 20;
  difference() {
    cornerless_cube(motor_width, motor_height, adapter_depth, 8.0);

    translate([motor_width/2, motor_height/2]) {
      motor_mount_holes();

      // translate([-motor_width/2/iratio, -motor_height/2/iratio, thickness])
        // cornerless_cube(motor_width/iratio, motor_height/iratio, adapter_depth);

      // cylinder(r=motor_axle_hole_r, h=long, center=true);

      translate([0,0,-0.01])
        cylinder(r=motor_ring_r, h=long);
    }

    translate([motor_width/2-ibar/2, -1, thickness]) {
      cube([ibar, long, adapter_depth]);
    }

    translate([-1, motor_height/2-ibar/2, thickness]) {
      cube([long, ibar, adapter_depth]);
    }
  }

}

mount_adapter();
