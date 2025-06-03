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

module drilling(){
  rotate([45,0,0])
  cylinder(h=40, d=3, $fn=10);

  rotate([-45,0,0])
  cylinder(h=40, d=3, $fn=10);

}

module outer() {
  difference(){
    sphere(outer_radius_outer, $fn=100);
    sphere(outer_radius_inner, $fn=100);

    translate([-50,-50,-100])
    cube([100,100,100]);
      
    translate([26,-5.5,0])
    usbOpening();
      
    drilling();
  }
}

module innerFilled() {
  difference() {
    sphere(inner_radius_outer, $fn=100);
      
    translate([-50,-50,-100])
    cube([100,100,100]);
      
    translate([23,-5.5,0])
    usbOpening();
      
    translate([-16,-electronicSpace_width/2,0])
    electronicSpace();
      
    drilling();
  }
}

//color("red", 0.15)
//innerFilled();

//color("green", 0.15)
//rotate([90,0,0])
//outer();

module esp() {
  cube([23.5, 18, 1.5]);
}
module bmi60() {
  cube([18, 13, 1.5]);
}

module battery() {
  cube([40, 20, 7.5]);
}
module miniHalterung(){
   // 13 x 18
   // 23,5 x 18 x 1,5
   // 40 x 20 x 7,5
   esp();
   
   translate([0,0, 10])
   bmi60();
   
   translate([0,0, 20])
   battery();

}

// miniHalterung();

//color("black")
//translate([1.5 ,2,1])
//cube([23.5, 18, 1.5]);

//color("green", 0.25)

module rahmen() {
  difference() {
    color("red", 0.25)
    cube([25,22,9]);
        
    // luft
    translate([2, 2.5, -1])
    cube([24,17,15]);
        
    // schlitz
    translate([1,1.5,1])
    cube([24.5, 19, 1.6]);
      
    // usb
    translate([-5,6.25,2.5])
    cube([10, 10, 5]);
  }
}

module rahmen2() {
  difference() {
    cube([25,20.4,6]);
        
    // luft
    translate([2, 1.7, -1])
    cube([24,17,15]);
        
    // schlitz
    translate([1,0.8,0.8])
    cube([24.5, 19, 1.6]);
      
    // usb
    translate([-5,5.6,1.40])
    cube([10, 10, 4]);
  }
}

rahmen2();
//translate([1,2,3])
//esp();