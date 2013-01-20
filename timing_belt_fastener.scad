include <scad/tapercube.scad>;

long=100;
shim=0.1;
fudge = 0.3;

bolt_r = 3.0+fudge;

module fastener(between=20, w=35, h=12, th=3) {
  difference() {
    cornerless_cube(w, h, th, 5.0);

    translate([w/2-between/2, h/2, -shim])
      cylinder(r=bolt_r, h=long, $fn=48);

    translate([w/2+between/2, h/2, -shim])
      cylinder(r=bolt_r, h=long, $fn=48);
  }  
}

fastener();