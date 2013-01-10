ibar = 20.0;

fudge = 0.4;
thin = 0.01;

wall_th = 0.8*1.5;

box_w = 55.0-1.6*2;
box_h = 83.17-1.6*2;

ha = 6.5;
hb = 23;
hc = 39;

$fn=48;

module hole(x, y) {
  translate([x, y, -thin])
    cylinder(r=2, h=10);
}

module panel_back() {
  difference() {
    union() {
      cube([box_w, box_h, wall_th]);
      translate([box_w/2-10/2-5, box_h/2-ibar/2, 0])
        difference() {
          cube([10, ibar, 10]);
          translate([0, ibar/4, 0])
            cube([10, ibar/2, 10]);
        }
    }

    hole(ha, ha);
    hole(ha, box_h-ha);
    hole(hc, hb);
    hole(hc, box_h-hb);
  }
}

panel_back();
