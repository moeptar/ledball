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

module innerFilledBox() {
  difference() {
    sphere(inner_radius_outer, $fn=50);
      
    // halbkugel
    translate([-50,-50,-100])
    cube([100,100,100]);
      
    // box Öffnung
    cube([50,24,16], center=true);
      
    // usb
    cube([120,10,10], center = true);
      
    // LED
    translate([0,0,6])
    cube([6,6,6], center = true);
      
    drillingInner();
  }
}

module schalter(){
  translate([-5.8 / 2, 5.8/2, 5.1 / 2]){
    cube([5.8,5.8,5.1], center = true);

    translate([0,0,5.1/2 + 2.5/2])
    cube([3.5,2.9,2.5], center = true);
    
    translate([0,0,5.1 / 2 + 5.1 / 2])
    cube([2,2.4, 5.1], center = true);
    }
}

module innerFilledBoxTest() {
  innenLaenge =  50;
  innenBreite = 24; 
  innenHoehe = 16;
  dickeVorne = 1.6;
  dickeSeite = 1.6;
  dickeUnten = 1.6;
  oeffnungBreite = 10;
  oeffnungHoehe = 10;

  difference() {
    cube([innenLaenge + dickeVorne * 2, innenBreite + dickeSeite *2 ,innenHoehe / 2 + dickeUnten]);
      
    // box Öffnung
    translate([dickeVorne, dickeSeite, dickeUnten])
    cube([innenLaenge,innenBreite,16]);
      
    // usb
    translate([0, dickeSeite + innenBreite/2 - 5, dickeUnten + innenHoehe / 4])
    cube([innenLaenge + 2* dickeVorne, oeffnungHoehe, oeffnungBreite]);
      
    // LED
    translate([dickeVorne + innenLaenge/2 -3, dickeSeite+ innenBreite/2 -3,-3])
    cube([6,6,6]);  
  }
}  
    
  //halterung
//  translate([dickeVorne, dickeSeite, dickeUnten])
//  cube([24,2,3]);
  
//  translate([dickeVorne, innenBreite, dickeUnten])
//  cube([24,2,3]);  

module chipSupport(){
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
    cube([1, 14, 10]);
      
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
  cube([cubeSize,6,3]);
  translate([innenLaenge-cubeSize -1.5, innenBreite/2 - 0.5,0])
  cube([1,1,4]);
  translate([innenLaenge-cubeSize +2, innenBreite/2 - 5,0])
  cube([2,2,6]);  
  translate([innenLaenge-cubeSize +2, innenBreite/2 + 3,0])
  cube([2,2,6]);

  
  // button hole
 difference() {
    translate([innenLaenge-1,4.5,0])
    cube([1, 14, 10]);
      
    translate([innenLaenge - 1.5,10,4])
    cube([2, 3.5, 4]);
  }  
//  
  
}

//rotate([180,0,0])
//color("red", 0.25)
//innerFilledBoxTest();

//translate([1.6,1.6,1.6])
//chipSupport();


  innenLaenge =  49;
  innenBreite = 23;
  innenHoehe = 16;
  cubeSize = 6;
  espLaenge = 25;
  holeSize = 10;

/**
  // button stuetze
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,0])
  cube([cubeSize,6,3]);
  translate([innenLaenge-cubeSize -1.5, innenBreite/2 - 0.5,0])
  cube([1,1,4]);
  translate([innenLaenge-cubeSize +2, innenBreite/2 - 5,0])
  cube([2,2,6]);  
  translate([innenLaenge-cubeSize +2, innenBreite/2 + 3,0])
  cube([2,2,6]);

  
  // button hole
 difference() {
    translate([innenLaenge-1,4.5,0])
    cube([1, 14, 10]);
      
    translate([innenLaenge - 1.5,10,3])
    cube([2, 3.5, 5]);
  }  
**/
/**
  // button stuetze
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,0])
  cube([cubeSize,6,3]);
  translate([innenLaenge-cubeSize -1.5, innenBreite/2 - 3,0])
  cube([1,6,4]);
  translate([innenLaenge-cubeSize -1.5, innenBreite/2 - 4,0])
  cube([6.5,1,9]);  
  translate([innenLaenge-cubeSize -1.5, innenBreite/2 + 3,0])
  cube([6.5,1,9]);
  color("red")
  translate([innenLaenge-cubeSize +4, innenBreite/2-7 + 3,9])
  cube([1,8,1]);
  
  // button hole
 difference() {
    translate([innenLaenge-1,4.5,0])
    cube([1, 14, 10]);
      
    translate([innenLaenge - 1.5, 9.25,3])
    cube([2, 4.5, 5]);
  }  
**/

  // button stuetze
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,0])
  cube([cubeSize,6,2]);

  // oben
  translate([innenLaenge-cubeSize-0.5, innenBreite/2 - 3,8])
  cube([cubeSize,6,2]);
  
  translate([innenLaenge - cubeSize - 3, innenBreite/2 +3 ,4.25])
  cube([cubeSize + 2,1.5,2]);
  translate([innenLaenge - cubeSize - 3, innenBreite/2 +1 ,4.25])
  cube([2,2,2]);

  color("red")
  translate([innenLaenge - cubeSize -3, innenBreite/2 -5 ,4.25])
  cube([cubeSize + 2,1.5,2]);
  color("green")
  translate([innenLaenge - cubeSize - 3, innenBreite/2 -3.5 ,4.25])
  cube([2,2,2]);
  
  // button hole
 difference() {
    translate([innenLaenge-1,4.5,0])
    cube([1, 14, 10]);
      
    translate([innenLaenge - 1.5, 9.25,2.5])
    cube([2, 4.5, 5]);
  }  

//rotate([0,90,0])

//color("blue")
//translate([-4.5,10.5,45.5])
//schalter();
//color("red", 0.25)
//outer();




