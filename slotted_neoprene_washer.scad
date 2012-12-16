include <scad/tapercube.scad>;

long=30;

hole_r = 3.0;
peg_r = 2.6;

neoprene_width = 8.0;
neoprene_thick = 2.3;
neoprene_inset = 4.5;

$fn=48;

module washer(width=42, height=15, depth=3.0) {
  difference() {
    // cube([width, height, depth]);
    union() {
      cornerless_cube(width, height, depth, 4.0);
      translate([width/2-10, height/2, depth])
        cylinder(r=peg_r, h=2.5);    
    }

    translate([width/2+10, height/2, 0])
      cylinder(r=hole_r, h=long, center=true);

    translate([neoprene_inset - neoprene_thick/2, height/2 - neoprene_width/2, -long/2])
      cube([neoprene_thick, neoprene_width, long]);

    translate([width - neoprene_inset - neoprene_thick/2, height/2 - neoprene_width/2, -long/2])
      cube([neoprene_thick, neoprene_width, long]);
  }
}

washer();