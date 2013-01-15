include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

motor_width = 42.25;
motor_mount_ring_r = 11.0 + fudge;
motor_mount_hole_r = 1.75 + fudge;
motor_mount_height = 7.5;
motor_dist_between_mount_holes = 31;

makerslide_h = 20.0;
makerslide_w = 40.0;

makerslide_bracket_sleeve = 20.0;

bracket_thk = 5.0;
bracket_w = 10.0;
bracket_h = makerslide_w + bracket_thk*2;
bracket_d = makerslide_h + bracket_thk;

module motor_mount_holes() {
  d = motor_dist_between_mount_holes;
  r = sqrt(d*d*2)/2;
  for (theta=[45,135,225,315])
    translate([cos(theta)*r, sin(theta)*r])
      cylinder(r=motor_mount_hole_r, h=long, center=true, $fn = 48);
}

module ramp() {
  hull() {
    translate([10, 0, 0])
    cube([shim, bracket_w-1, motor_mount_height]);
    cube([10, bracket_w-1, shim]);
  }
}

difference() {
  union() {
    cornerless_cube(motor_width, motor_width+10.0, motor_mount_height, 8.0);

    translate([0, 1.00, 0]) { // move 1 unit up to accommodate tapercube
      translate([-2.87, motor_width, 0])
        ramp();

      translate([motor_width+2.87, motor_width, 0])
        mirror([1, 0, 0])
          ramp();
    }

    translate([motor_width/2-bracket_h/2, motor_width, -bracket_d])
      tapercube(bracket_h, bracket_w + makerslide_bracket_sleeve, bracket_d, 2.0);
  }
  
  translate([motor_width/2, motor_width/2]) {
    motor_mount_holes();
    translate([0, 0, -shim])
      cylinder(r=motor_mount_ring_r, h=long, $fn = 64);
      translate([-motor_mount_ring_r, 0, -shim])
        cube([motor_mount_ring_r*2, long, long]);
  }

  //makerslide
  translate([motor_width/2-makerslide_w/2, motor_width + bracket_w, -makerslide_h]) {
    cube([makerslide_w, makerslide_bracket_sleeve+shim, makerslide_h+shim]);
    
    translate([-long/3, makerslide_bracket_sleeve/2, makerslide_h/2])
      rotate([0, 90, 0])
        cylinder(r=3.2, h=long, $fn=48);    

    translate([makerslide_w/2-makerslide_w/4, makerslide_bracket_sleeve/2, -long/2])
      cylinder(r=3.2, h=long, $fn=48);    

    translate([makerslide_w/2+makerslide_w/4, makerslide_bracket_sleeve/2, -long/2])
      cylinder(r=3.2, h=long, $fn=48);

    translate([0, 0, makerslide_h]) {
      translate([0, 0, 0])
        rotate([0, 45, 0])
          translate([-5, 0, -2.2])
            cube([10, makerslide_bracket_sleeve+shim, 5]);

      translate([makerslide_w, 0, 0])
        rotate([0, -45, 0])
          translate([-5, 0, -2.2])
            cube([10, makerslide_bracket_sleeve+shim, 5]);
    }
  }
}
