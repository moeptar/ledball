// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T
// https://www.luisllamas.es/en/esp32-pwm/

void setLed(int pin, String rgb){
  Serial.print("Set LED ");
  Serial.print(pin);
  Serial.print(" to");
  Serial.print(rgb.substring(0,2));
  Serial.print(",");
  Serial.print(rgb.substring(2,4));
  Serial.print(",");
  Serial.print(rgb.substring(4,6));
  Serial.print(")");
  Serial.println();
}

void performAction(String actionString){
  switch (actionString.charAt(0)){
    case 'L': // LED
      setLed(1, actionString.substring(1,7));
      setLed(2, actionString.substring(7,13));
      break;
    case 'D': // delay
      Serial.print("Waiting ");
      Serial.print(actionString.substring(1));
      Serial.print(" ms");
      Serial.println();
      break;
  }
}

void setup() {
    Serial.begin(115200);
}

String testprogramm = "LFF000000FF00;D1000;L00FF000000FF;D2000;L0000FFFF0000;D1500;";
int idx;
int nextIdx;

void loop() {
  nextIdx = idx + testprogramm.substring(idx).indexOf(";") + 1;
//  Serial.println(testprogramm.substring(idx, nextIdx));  
  performAction(testprogramm.substring(idx, nextIdx-1));

  idx = nextIdx;
  if(idx >= testprogramm.length()){
    idx = 0;
  }

  delay(1000);
}
