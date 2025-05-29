
int freq = 5000;
int resolution = 8;
int red1pin = 5;
int green1pin = 4;
int blue1pin = 2;

void fadeLed(int ledPin){
  for(int i = 0; i<= 255; i++){
    analogWrite(ledPin, i);
    delay(10);
  }
  for(int i = 255; i>= 0; i--){
    analogWrite(ledPin, i);
    delay(10);
  }
}

void ledAll(int brigthness){
  analogWrite(red1pin, brigthness);
  analogWrite(green1pin, brigthness);
  analogWrite(blue1pin, brigthness);
}

void setup() {
  analogWriteResolution(red1pin, 8);
  analogWriteResolution(green1pin, 8);
  analogWriteResolution(blue1pin, 8);
}

void loop() {
fadeLed(red1pin);
fadeLed(green1pin);
fadeLed(blue1pin);
}
