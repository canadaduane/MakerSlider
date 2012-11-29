mount_r=33;

bolt_bare_h=18;
bolt_head_h=5;
bolt_head_r=9;
bolt_shaft_r=4.75;
full_h=bolt_bare_h+bolt_head_h;

small_bolt_space_r=12;
small_bolt_head_h=5;
small_bolt_shaft_r=3.25;

difference() {
  cylinder(r=mount_r, h=full_h, $fn=64);

  cylinder(r=bolt_head_r, h=bolt_head_h, $fn=6);
  cylinder(r=bolt_shaft_r, h=full_h, $fn=48);

  translate([0,mount_r/3*2,0]) {
    translate([0,0,full_h-small_bolt_head_h]) {
      cylinder(r=small_bolt_space_r, h=small_bolt_head_h, $fn=64);
      for(y=[1,2,3,4,5,6,7,8])
        translate([0, y, 0])
          cylinder(r=small_bolt_space_r, h=small_bolt_head_h, $fn=64);
    }
    cylinder(r=small_bolt_shaft_r, h=full_h, $fn=48);
  }
}