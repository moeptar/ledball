// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// F -> FADE(RGB1, RGB2, ms)
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T
// 
// https://randomnerdtutorials.com/esp32-web-bluetooth/
// https://www.espboards.dev/esp32/esp32-s3-super-mini/
// https://x10hosting.com/

#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <FastLED.h>

#define BALL_NAME "Ball 1"

#define SERVICE_UUID             "26baf7e5-dc66-494d-af84-1e5a9074ff46"
#define BALL_CHARACTERISTIC_UUID "85d17ec3-1385-4b86-b0af-c473d77a45b3"
#define RESOLUTION 8

#define NUM_LEDS 1
#define DATA_PIN 48

BLEServer* pServer = NULL;
BLECharacteristic* pBallCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;

CRGB leds[NUM_LEDS];

String testprogramm = "LFF0000;D250;L00FF00;D500;L0000FF;D1000;";

String currentProgram = testprogramm;
int currentIndex;
int nextIndex;

class MyServerCallbacks: public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) {
    Serial.print("Device connected");
    deviceConnected = true;
  };

  void onDisconnect(BLEServer* pServer) {
    Serial.print("Device disConnected");
    deviceConnected = false;
  }
};

void setupBluetooth() {
  BLEDevice::init(BALL_NAME);
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  
  BLEService *pService = pServer->createService(SERVICE_UUID);

  pBallCharacteristic = pService->createCharacteristic(
                      BALL_CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ
                      | BLECharacteristic::PROPERTY_NOTIFY
                    );

  pBallCharacteristic->addDescriptor(new BLE2902());

  pService->start();

  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  BLEDevice::startAdvertising();

}

void checkConnection(){
  if (!deviceConnected && oldDeviceConnected) {
    Serial.println("Device disconnected.");
    delay(500);
    pServer->startAdvertising();
    Serial.println("Start advertising");
    oldDeviceConnected = deviceConnected;
  }

  if (deviceConnected && !oldDeviceConnected) {
    oldDeviceConnected = deviceConnected;
    Serial.println("Device Connected");
  }
}

void performAction(String actionString){
  if (deviceConnected) {
    pBallCharacteristic->setValue(actionString);
    pBallCharacteristic->notify();
    Serial.print("New value notified: ");
    Serial.println(actionString);
  }
  Serial.println(actionString);
  switch (actionString.charAt(0)){
    case 'L': // LED
      leds[0].r = substringHexToInt(actionString, 1, 3); 
      leds[0].g = substringHexToInt(actionString, 3, 5); 
      leds[0].b = substringHexToInt(actionString, 5, 7);
      FastLED.show();  
      break;
    case 'D': // DELAY
      delay(actionString.substring(1).toInt());
      break;
  }  
}

int substringHexToInt(String text, int start, int end){
  return strtol(text.substring(start,end).c_str(), NULL, 16);
}

void nextProgramStep(){
  nextIndex = currentIndex + currentProgram.substring(currentIndex).indexOf(";") + 1;
  performAction(currentProgram.substring(currentIndex, nextIndex-1));
  currentIndex = nextIndex;
  if(currentIndex >= currentProgram.length()){
    currentIndex = 0;
  }
}

void setup() {
  Serial.begin(115200);
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  setupBluetooth();
}

void loop() {
  nextProgramStep();
  checkConnection();
}
