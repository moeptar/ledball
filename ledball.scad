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

module esp() {
  cube([23.5, 18, 1.5]);
}
module bmi60() {
  cube([18, 13, 1.5]);
}

module battery() {
  cube([40, 20, 7.5]);
}

module rahmen2() {
  difference() {
    color("red", 0.25)
    cube([25,20.4,8]);
        
    // luft
    translate([2, 1.7, -1])
    cube([24,17,15]);
        
    // schlitz esp
    translate([1,0.8,0.8])
    cube([24.5, 19, 1.6]);
      
    // schlitz bmi
    rotate([0,0,90])
    translate([0.75,-25,5])
    cube([19, 14, 1.6]);
          
    // usb
    translate([-5,5.6,1.40])
    cube([10, 10, 4]);
  }
}

module rahmen3() {
  difference() {
    color("red", 0.25)
    cube([25,20.4,10]);
        
    // luft
    translate([2, 1.7, -1])
    cube([24,17,15]);
        
    // schlitz esp
    translate([1,0.8,2.8])
    cube([24.5, 19, 1.6]);
      
    // schlitz bmi
    rotate([0,0,90])
    translate([0.75,-25,8])
    cube([19, 14, 1.6]);
          
    // usb
    translate([-5,5.6,3.40])
    cube([10, 10, 4]);
  }
  
  // halterung 1
  rotate([0,0,90])
  translate([0,-27,0])
  cube([5, 2, 10]);
  
  // halterung 2
  rotate([0,0,90])
  translate([15.5,-27,0])
  cube([5, 2, 10]);

}

/*
translate([0,0,-4])
rahmen3();

rotate([0,0,90])
translate([-10,-48,-4])
battery();

color("red", 0.25)
translate([outer_radius_inner - 2.5,10,0])
difference() {
    sphere(inner_radius_outer, $fn=100);
      
    translate([-50,-50,-100])
    cube([100,100,100]);
}
*/
//translate([1,2,3])
//esp();

//rahmen3();

module innenraum() {
  union(){
    
    translate([25,-21,-4])
    cube([22, 42, 8]);

    translate([0,-11,-5])
    cube([25,22,10]);
  }
}

module ring(){
  difference(){
    sphere(inner_radius_outer, $fn=50);

    translate([-50,-50,-100])
    cube([100,100,100]);
      
    translate([-50,-50,10.4])
    cube([100,100,100]);
  }
    
    
}

/*
difference(){
    union(){
        translate([24,-22,-6])
        cube([24, 44, 10]);

        translate([-1,-12,-6])
        cube([26,24,10]);
        
    }
//  translate([26.5,0,0])
//  ring();

  innenraum();
}
*/


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
      
    drilling();
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

innerFilledBoxTest();