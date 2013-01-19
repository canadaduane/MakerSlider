include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

motor_width = 42.25;
motor_mount_ring_r = 11.0 + fudge;
motor_mount_hole_r = 1.75 + fudge;
motor_mount_height = 7.5;
motor_mount_opening = 20;
motor_mount_opening_offset = 5.0+fudge;
motor_dist_between_mount_holes = 31;

leg_bolt_r = 3.0+fudge;
leg_extra = 30.0;
leg_height = 15.0;

module motor_mount_holes() {
  d = motor_dist_between_mount_holes;
  r = sqrt(d*d*2)/2;
  for (theta=[45,135,225,315])
    translate([cos(theta)*r, sin(theta)*r])
      cylinder(r=motor_mount_hole_r, h=long, center=true, $fn = 48);
}

module motor_mount() {
  difference() {
    union() {
      cornerless_cube(motor_width, motor_width, motor_mount_height, 8.0);
  
      translate([motor_width/2, motor_width/2]) {
        rotate([0, 0, 45]) {
          translate([-motor_mount_opening/2+motor_mount_opening_offset-motor_mount_height, motor_mount_ring_r, leg_height])
            rotate([0, 90, 0])
              cornerless_cube(leg_height, leg_extra, motor_mount_height, 3.0);

          translate([motor_mount_opening/2+motor_mount_opening_offset, 5, leg_height])
            rotate([0, 90, 0])
              cornerless_cube(leg_height, leg_extra+6, motor_mount_height, 3.0);
        }
      }
            // %cube([leg_height, leg_extra, motor_mount_height]);
      // rotate([0, 0, 90])
      //   translate([-motor_width/2, -motor_width/4])
      //     %cornerless_cube(motor_width, motor_width/2, motor_mount_height, 8.0);
    }
    
    translate([motor_width/2, motor_width/2]) {
      motor_mount_holes();

      // U-shaped opening in center of motor mount
      translate([0, 0, -shim])
        // Center
        cylinder(r=motor_mount_ring_r, h=long, $fn = 64);
        // U Legs
        rotate([0, 0, 45])
          translate([-motor_mount_opening/2+motor_mount_opening_offset, 0, -shim]) {
            cube([motor_mount_opening, long, long]);
            translate([-motor_mount_height, motor_mount_ring_r, leg_height])
              rotate([0, 90, 0])
                translate([leg_height/2, leg_extra-leg_bolt_r-5, -long/2])
                  cylinder(r=leg_bolt_r, h=long, $fn=48);
          }
    }
  }  
}

motor_mount();