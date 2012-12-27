outer_r=15.5/2;
inner_r=11.0/2;
h=7.7;

$fn=64;
difference() {
  cylinder(r=outer_r, h=h);
  cylinder(r=inner_r, h=h);
}