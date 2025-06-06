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
electronicSpace_width = 24;
electronicSpace_length = 41;
electronicSpace_hight = 12;

module usbOpening(){
  cube([10,11,6]);
}

module electronicSpace(){
  cube([electronicSpace_length , electronicSpace_width , electronicSpace_hight]);
}

module drillingInner(){
  rotate([22.5,0,0])
  translate([0,0,15])
  cylinder(h=15, d=3, $fn=10);

  rotate([-22.5,0,0])
  translate([0,0,15])
  cylinder(h=15, d=3, $fn=10);
}

module drillingOuter(){
  rotate([67.5,0,0])
  translate([0,0,25])
  cylinder(h=10, d=3, $fn=10);

  rotate([-67.5,0,0])
  translate([0,0,25])
  cylinder(h=10, d=3, $fn=10);
}


module outer() {
  difference(){
    sphere(outer_radius_outer, $fn=100);
    sphere(outer_radius_inner, $fn=100);

    //halbkugel
    translate([-50,-50,-100])
    cube([100,100,100]);
    
    // usb
    cube([120,10,10], center = true);
      
    drillingOuter();
  }
}

module innerFilledBox() {
  difference() {
    sphere(inner_radius_outer, $fn=50);
      
    // halbkugel
    translate([-50,-50,-100])
    cube([100,100,100]);
      
    // box Öffnung
    cube([50,22,14], center=true);
      
    // usb
    cube([120,10,10], center = true);
      
    // LED
    translate([0,0,6])
    cube([6,6,6], center = true);
      
    drillingInner();
  }
}

module innerFilledBoxTest() {
  difference() {
    cube([50.8,22.8,14.8], center = true);
      
    // halbkugel
    translate([-50,-50,-100])
    cube([100,100,100]);
      
    // box Öffnung
    cube([50,22,14], center=true);
      
    // usb
    cube([120,10,10], center = true);
      
    // LED
    translate([0,0,6])
    cube([6,6,6], center = true);
  }
}

innerFilledBox();

//color("red", 0.25)
//outer();
