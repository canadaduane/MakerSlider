include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

motor_width = 42.25;
motor_mount_ring_r = 11.0 + fudge;
motor_mount_hole_r = 1.75 + fudge;
motor_mount_height = 9.5;
motor_mount_opening = 20;
motor_mount_opening_offset = 10.0+fudge;
motor_dist_between_mount_holes = 31;

leg_bolt_r = 3.0+fudge;
leg_bolt_head_r = 4.5+fudge;
leg_bolt_head_seat = 2.5;
leg_extra = 30.0;
leg_extra_bottom = 53.0;
leg_bottom_2nd_hole = 16.0;
leg_height = 13.5;

module motor_mount_holes() {
  d = motor_dist_between_mount_holes;
  r = sqrt(d*d*2)/2;
  for (theta=[45,135,225,315])
    translate([cos(theta)*r, sin(theta)*r])
      cylinder(r=motor_mount_hole_r, h=long, center=true, $fn = 48);
}

module bolt_neg(shaft_height, head_height) {
  // shaft of bolt
  translate([0, 0, -shaft_height])
    cylinder(r=leg_bolt_r, h=shaft_height+shim, $fn=48);
  // head of bolt
  cylinder(r=leg_bolt_head_r, h=head_height, $fn=48);
}

module protrusion(w, h, d, shave=2) {
  // cube([w, h, d]);
  hull() {
    translate([0, 0, 0]) {
      cube([w-shave, h, shim]);
      translate([0, shave])
        cube([w, h-shave*2, shim]);
    }

    translate([0, 0, d]) {
      cube([w-shave, h, shim]);
      translate([0, shave])
        cube([w, h-shave*2, shim]);
    }
  }
}

module motor_mount_pos() {
  union() {
    cornerless_cube(motor_width, motor_width, motor_mount_height, 10.0);
    translate([motor_width/4*3, motor_width/4*3])
      cube([motor_width/4, motor_width/4, motor_mount_height]);

    translate([motor_width/2, motor_width/2]) {

      // Protrusion that slides into makerslide (top)
      translate([2, motor_width/2, motor_mount_height])
        rotate([270, 0, 0])
          protrusion(3.9, motor_mount_height, 20);

      // Protrusion that slides into makerslide (bottom)
      translate([motor_width/2 - 4 - 3 + 4, motor_width/2])
        rotate([270, 180, 0])
          protrusion(3.9, motor_mount_height, 20);

      // translate([motor_mount_opening/2+motor_mount_opening_offset, 4, leg_height])
      //   rotate([0, 90, 0])
      //     cornerless_cube(leg_height, leg_extra_bottom, motor_mount_height, 3.0);
    }
  }
}

module motor_mount_neg() {
  translate([motor_width/2, motor_width/2]) {
    motor_mount_holes();

    translate([0, 0, -shim]) {
      // Hole in center for motor's protruding cylinder
      cylinder(r=motor_mount_ring_r, h=long, $fn = 64);

      // Remove back portion so that screwdriver can access MXL pulley
      translate([-motor_mount_ring_r, -motor_width/2-shim])
        cube([motor_mount_ring_r*2, motor_mount_ring_r*2, motor_mount_height+shim*2]);

      // U Legs
      // translate([-motor_mount_opening/2+motor_mount_opening_offset, 0]) {
      //   translate([-motor_mount_height, motor_mount_ring_r, leg_height]) {
      //     rotate([0, 90, 0]) {
      //       translate([0, 0, motor_mount_opening + motor_mount_height*2 - leg_bolt_head_seat]) {
      //         translate([leg_height/2, leg_extra-leg_bolt_r-5])
      //           bolt_neg(motor_mount_height, motor_mount_height);
      //         translate([leg_height/2, leg_extra-leg_bolt_r-5 + leg_bottom_2nd_hole])
      //           bolt_neg(motor_mount_height, motor_mount_height);
      //       }
      //     }
      //   }
      // }
    }
  }
}
module motor_mount() {
  translate([-motor_width/2, -motor_width/2]) {
    difference() {
      motor_mount_pos();
      motor_mount_neg();
    }
  }  
}

motor_mount();

// protrusion(4, motor_mount_height, 20);