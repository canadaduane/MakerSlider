include <scad/tapercube.scad>;

fudge = 0.15;

module grbl_shield_shell() {
  battery_inner_width = 60.5 + fudge;
  battery_outer_width = 64.5;

  battery_ridge_depth = 5.5;
  battery_ridge_thickness = (battery_outer_width - battery_inner_width)/2;

  arduino_board_thickness = 1.72 + fudge;
  arduino_board_width = 53.3 + fudge;
  arduino_width = arduino_board_width - 1.0;

  grbl_shield_thickness = 1.52 + fudge;
  grbl_shield_width = 58.4 + fudge;
  grbl_width = grbl_shield_width - 1.0;
  grbl_depth = 10.6;

  solder_thickness = 2.6;

  arduino_grbl_distance = 11.3;

  maximum_extent_height = 83.6;
  maximum_extent_depth = 36.0;

  main_height = maximum_extent_height - battery_ridge_thickness;
  main_y = -0.01;

  wafer = 0.001;

  difference() {
    // cube([battery_outer_width, maximum_extent_height, maximum_extent_depth]);
    tapercube(battery_outer_width, maximum_extent_height, maximum_extent_depth);

    translate([battery_ridge_thickness, main_y, -wafer])
      cube([battery_inner_width, main_height, battery_ridge_depth + wafer]);

    translate([battery_outer_width/2 - arduino_width/2, main_y, battery_ridge_depth - wafer])
      cube([arduino_width, main_height, solder_thickness + wafer]);

    translate([battery_outer_width/2 - arduino_board_width/2, main_y, battery_ridge_depth + solder_thickness - wafer])
      cube([arduino_board_width, main_height, arduino_board_thickness + wafer]);

    translate([0, main_y, battery_ridge_depth + solder_thickness + arduino_board_thickness - wafer]) {
      // cube([arduino_width, main_height, arduino_grbl_distance + wafer]);
      hull() {
        translate([battery_outer_width/2 - arduino_width/2, 0, 0])
          cube([arduino_width, main_height, wafer]);
        translate([battery_outer_width/2 - grbl_width/2, 0, arduino_grbl_distance])
          cube([grbl_width, main_height, wafer]);
      }
    }

    translate([battery_outer_width/2 - grbl_shield_width/2, main_y, battery_ridge_depth + solder_thickness + arduino_board_thickness + arduino_grbl_distance - wafer])
      cube([grbl_shield_width, main_height, grbl_shield_thickness + wafer]);

    translate([battery_outer_width/2 - grbl_width/2, main_y, battery_ridge_depth + solder_thickness + arduino_board_thickness + arduino_grbl_distance + grbl_shield_thickness - wafer])
      cube([grbl_width, main_height, grbl_depth + wafer]);
  }
}

rotate([0, 180, 0])
grbl_shield_shell();