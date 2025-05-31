// ‎3,8 x 2,1 x 0,9 cm
// 1,8 / 2,4 / 2,5 x 0,45-0,9-0,45 / 1,8 x 0,3 / 0,45
// https://www.reddit.com/r/esp32/comments/1hy62lc/battery_monitoring_on_esp32s3_super_mini_dev_board/
//https://www.pangodream.es/esp32-getting-battery-charging-level
// https://how2electronics.com/esp32-with-bmi160-accelerometer-gyroscope-sensor/




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

module usbSupport(){
  cube([2,18,9]);
    
  translate([-inner_radius_inner,2.5,7])
  cube([inner_radius_inner*2,2,2]);

  translate([-inner_radius_inner,13.5,7])
  cube([inner_radius_inner*2,2,2]);
}

module usbOpening(){
  cube([6,9,5]);
}

module dummy(){
  cube([38, 21, 9]);  
  translate([20,1.5,9])
  esp();
}

module printSupport() {
    translate([-1,-1,0])
    cube([2,2,inner_radius_inner+2]);
}

translate([-1,-9,0])
usbSupport();
printSupport();

difference(){
  innerUpper();
  translate([24 ,-4.5,6])
  usbOpening();
}
//outerUpper()