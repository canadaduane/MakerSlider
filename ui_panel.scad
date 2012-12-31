space_w = 19.5;
space_h = 25.0;

panel_w = 60.0;
panel_h = 30.0;
panel_d = 2.4;
// outer width 42

clip_w = 2.0;
clip_h = 5.0;
clip_d = 11.5;

%translate([panel_w/2, panel_h/2, panel_d+clip_d]) {
  difference() {
    translate([-panel_w/2, -panel_h/2, -2])
      cube([panel_w, panel_h, 2]);
    translate([-space_w/2, -space_h/2, -2.01])
      cube([space_w, space_h, 2.02]);
  }
}

module clip(w, h, d) {
  end_w = 2.0;
  end_d = 2.4;

  union() {
    cube([w, h, d+end_d]);
    hull() {
      translate([w, 0, d]) {
        // flat
        cube([end_w, h, 0.001]);
        // upright
        cube([0.001, h, end_d]);
      }
    }
  }
}

module clip4(x_from_center=space_w/2, y_from_center=space_h/2) {
  for (x=[-1,1])
    for (y=[-1,1])
      scale([x, y, 1])
        translate([x_from_center-clip_w, y_from_center-clip_h])
          clip(clip_w, clip_h, clip_d);
}

union() {
  cube([panel_w, panel_h, panel_d]);

  translate([panel_w/2, panel_h/2, panel_d])
    clip4();
}