
module tapercube(width=10, height=10, depth=10, taper=3.0) {
  plane = 0.001;
  hull() {
    translate([taper/2,taper/2,0])
      cube([width-taper, height-taper, plane]);
    translate([0,0,taper/2]) {
      translate([0,taper/2])
        cube([width, height-taper, plane]);
      translate([taper/2,0])
        cube([width-taper, height, plane]);
    }

    translate([taper/2,taper/2,depth-plane])
      cube([width-taper, height-taper, plane]);
    translate([0,0,depth-taper/2]) {
      translate([0,taper/2])
        cube([width, height-taper, plane]);
      translate([taper/2,0])
        cube([width-taper, height, plane]);
    }
  }
}