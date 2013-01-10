fudge = 0.4;
thin = 0.01;

wall_th = 0.8;

box_w = 55.0+fudge*2;
box_h = 83.17+fudge*2;
box_d = 14.4+fudge*2;

knob_r = 4.0+fudge;
knob_x = 20.1+3.5;
knob_y = 39.0+3.5;

spacer_d = 3.4 - wall_th;
spacer_th = 2.8;

knob_spacer_r = knob_r+spacer_th;
button_spacer_th = spacer_th;

button_w = 18.2+fudge*2;
button_h = 12.0+fudge*2;

button1_x = 11.6+3.5;
button1_y = 60.7+3.5;

button2_x = 11.6+3.5;
button2_y = 5.25+3.5;

$fn = 48;

module button(x, y) {
  translate([x, y, -thin])
    cube([button_w, button_h, 10]);
}

module knob(x, y) {
  translate([x, y, -thin])
    cylinder(r=knob_r, h=10);
}

module cord(x, y, z) {
  translate([x, y, z])
    rotate([0, 90, 0])
      cylinder(r=4.0, h=10);
}

union() {
  difference() {
    cube([box_w, box_h, box_d]);

    translate([wall_th*3, wall_th*3, wall_th+thin])
      cube([box_w-wall_th*6, box_h-wall_th*6, box_d-wall_th]);

    translate([wall_th*2, wall_th*2, box_d-wall_th*1.5])
      cube([box_w-wall_th*4, box_h-wall_th*4, box_d-wall_th]);

    button(button1_x, button1_y);

    button(button2_x, button2_y);

    knob(knob_x, knob_y);

    cord(box_w-5, knob_y, box_d-2);
  }

  translate([knob_x, knob_y, wall_th]) {
    difference() {
      cylinder(r=knob_spacer_r, h=spacer_d);
      knob(0, 0);
    }
  }

  translate([button1_x-button_spacer_th, button1_y-button_spacer_th, wall_th]) {
    difference() {
      cube([button_w+button_spacer_th*2, button_h+button_spacer_th*2, spacer_d]);
      button(button_spacer_th, button_spacer_th);
    }
  }

  translate([button2_x-button_spacer_th, button2_y-button_spacer_th, wall_th]) {
    difference() {
      cube([button_w+button_spacer_th*2, button_h+button_spacer_th*2, spacer_d]);
      button(button_spacer_th, button_spacer_th);
    }
  }
}