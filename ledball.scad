// ‎3,8 x 2,1 x 0,9 cm
// 1,8 / 2,4 / 2,5 x 0,45-0,9-0,45 / 1,8 x 0,3 / 0,45

outer_diameter = 70;
outer_thickness = 5;
inner_thickness = 3;

outer_radius_outer = outer_diameter / 2;
outer_radius_inner = ( outer_diameter / 2) - outer_thickness;
inner_radius_outer = outer_radius_inner;
inner_radius_inner = outer_radius_inner - inner_thickness;

module battery(){
  color("blue", 0.5)
  cube([38, 21, 9], center = true);
}

module esp(){
//  color("green", 0.5)
  cube([24, 18, 3]);
    
  translate([18,4.5,3])
  cube([9, 7.5, 3.5]);
}

module inner() {
  difference() {
    sphere(inner_radius_outer, $fn=100);
    sphere(inner_radius_inner, $fn=100);
  }
}

module outer() {
  difference() {
    sphere(outer_radius_outer, $fn=100);
    sphere(outer_radius_inner, $fn=100);
  }
}

module upper_cube() {
  size = outer_diameter + 5;
  translate([-size/2,-size/2,0])
  cube([size,size,size/2]);
}

module innerUpper() {
  intersection() {
    upper_cube();
    inner();
  }        
}

module outerUpper() {
  intersection() {
    upper_cube();
    outer();
  }        
}

module auflage(){
  cube([2,18,9]);

  color("green")
  translate([1.5,0,4])
  cube([1,1,1]);
    
  color("green")
  translate([1.5,17,4])
  cube([1,1,1]);

  translate([26,2.5,0])
  cube([2,13,2]);

  color("red")
  translate([25,2.5,7])
  cube([3,13,2.5]);

  translate([0,2.5,0])
  cube([28,2,2]);
  translate([26.5,2.5,0])
  cube([1.5,2,9]);

  translate([0,13.5,0])
  cube([28,2,2]);
  translate([26.5,13.5,0])
  cube([1.5,2,9]);
    

}
//auflage();
//battery();
//color("red", 0.25)
//esp();
//difference(){
//  color("red", 0.25)
//  translate([-1,-1,0])
//  cube([25, 20, 8.5]);
//  esp();
//}
//battery();
//color("red", 0.25)
//innerUpper();
//outerUpper();