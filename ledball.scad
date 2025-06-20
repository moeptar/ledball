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
electronicSpace_length = 52;
electronicSpace_hight = 14;
inner_hole = 14;

module drillingInner(){
  rotate([22.5,0,0])
  translate([0,0,0])
  cylinder(h=45, d=3, $fn=10);

  rotate([-22.5,0,0])
  translate([0,0,0])
  cylinder(h=45, d=3, $fn=10);
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

module inner() {
  difference() {
    sphere(inner_radius_outer, $fn=100);
      
    // halbkugel
    translate([-50,-50,-100])
    cube([100,100,100]);
      
    // electronic hole
    cube([electronicSpace_length + 1,electronicSpace_width + 1,electronicSpace_hight + 1], center=true);
      
    // usb
    cube([120,inner_hole,inner_hole], center = true);
      
    drillingInner();
  }
}

module innerBox() {

  thickness = 2;

  difference() {
    cube([electronicSpace_length + 2 * thickness, electronicSpace_width + 2 * thickness,electronicSpace_hight/2 + thickness]);      
     
    // box Öffnung
    translate([thickness, thickness, thickness])
    cube([electronicSpace_length,electronicSpace_width,electronicSpace_hight]);
      
    // usb
    translate([-20,electronicSpace_width/2 - inner_hole / 2 + 2 ,electronicSpace_hight/2 - inner_hole / 2 + 2])
    cube([100, inner_hole, inner_hole / 2]);
  }
}

module chipSupport(){

  // front usbhole
  difference() {
    cube([1,electronicSpace_width, electronicSpace_hight]);
      // 10,4
    translate([-5,electronicSpace_width / 2 - 10/2,4])
    cube([20, 10, 4]);
  }
  
  // esp support
  translate([1,5.5,0])
  cube([24, 1, 3]);
  translate([25,5.5,0])
  cube([2, 1, 6]);
  
  translate([1,electronicSpace_width - 6.5,0])
  cube([24, 1, 3]);
  translate([25,electronicSpace_width - 6.5,0])
  cube([2, 1, 6]);
  
  // back buttonhole
  difference(){
    translate([electronicSpace_length - 1,0,0])
    cube([1,electronicSpace_width, electronicSpace_hight]);
  
    translate([electronicSpace_length -2,electronicSpace_width / 2 - 4.5/2,4.5])
    cube([4, 4.5, 5]);
  }
    
  // rigth / left
  cube([electronicSpace_length,2, 2]);
  translate([0,electronicSpace_width - 2,0])
  cube([electronicSpace_length,2, 2]);
 
  // button support
  difference(){
    translate([electronicSpace_length-7, electronicSpace_width/2 - 4,3])
    cube([6,8,8]);

    translate([electronicSpace_length-7, electronicSpace_width/2 - 3,4])
    cube([6,6,6]);
    
    translate([electronicSpace_length-4, electronicSpace_width/2 - 2.5,7])
    rotate([90,0,0])
    cylinder(h=2, d=3, $fn=10);  
  }
}

module chipSupportOld(){
  innenLaenge =  49;
  innenBreite = 23;
  innenHoehe = 16;
  cubeSize = 6;
  espLaenge = 25;
  holeSize = 10;

  //rahmen
  cube([1,innenBreite,1]); // vorne
  translate([innenLaenge -1, 0, 0]) // hinten
  cube([1,innenBreite,1]);
  cube([innenLaenge, 2,1]); // links
  translate([0, innenBreite - 2, 0]) // rechts
  cube([innenLaenge, 2,1]); 

  // usb
  difference() {
    translate([0,4.5,0])
    cube([1, 14, electronicSpace_hight]);
      
    translate([-0.5,6.5,4])
    cube([2, holeSize, 4]);
  }
  // links esp
  translate([1,4.5,0])
  cube([espLaenge, 1,3]);
  translate([espLaenge, 4.5, 3])
  cube([1, 1, 3]);
  
  // rechts esp
  translate([1,innenBreite -5.5,0])
  cube([espLaenge, 1,3]);
  translate([espLaenge, innenBreite - 5.5, 3])
  cube([1, 1, 3]);

  // bmi
//  color("red", 0.25)
//  translate([29,2.5,3])
//  cube([13, 18,1.5]);

//  translate([33,2.5,3])
//  cube([6, 18,1.5])
  
  // button stuetze
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,0])
  cube([cubeSize,6,2]);

  // oben
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,8])
  cube([cubeSize,6,2]);
  
  translate([innenLaenge - cubeSize - 3, innenBreite/2 +3 ,4.25])
  cube([cubeSize + 2,1.5,2]);
  translate([innenLaenge - cubeSize - 3, innenBreite/2 +1.5 ,4.25])
  cube([2,1.5,2]);

  translate([innenLaenge - cubeSize -3, innenBreite/2 -5 ,4.25])
  cube([cubeSize + 2,1.5,2]);
  translate([innenLaenge - cubeSize - 3, innenBreite/2 -3.5 ,4.25])
  cube([2,1.5,2]);
  
  // button hole
 difference() {
    translate([innenLaenge-1,4.5,0])
    cube([1, 14, electronicSpace_hight]);
      
    translate([innenLaenge - 1.5, 9.25,2.5])
    cube([2, 4.5, 5]);
  }  
}

//innerBox();
//translate([2,2, 2])
//chipSupport();



//color("red", 0.2)
//inner();
outer();
//rotate([180,0,0])
//color("green", 0.2)
//inner();

//rotate([0,0,180])
//translate([-electronicSpace_length/2,-electronicSpace_width/2,-electronicSpace_hight/2])
//chipSupport();

