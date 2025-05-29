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

#define BALL_NAME "Ball 1"

#define SERVICE_UUID             "26baf7e5-dc66-494d-af84-1e5a9074ff46"
#define BALL_CHARACTERISTIC_UUID "85d17ec3-1385-4b86-b0af-c473d77a45b3"

#define RESOLUTION 8

#define RED_1 5  // 1
#define GREEN_1 4 // 2
#define BLUE_1 2 // 4

#define RED_2 18 // 5
#define GREEN_2 19 // 6
#define BLUE_2 21 // 7

BLEServer* pServer = NULL;
BLECharacteristic* pBallCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;

String testprogramm = "LFF000000FF00;D1000;L00FF000000FF;D2000;L0000FFFF0000;D1500;";
String testprogramm2 = "LFF000000FF00;D250;L00FF000000FF;D500;L0000FFFF0000;D1000;";

String currentProgram = testprogramm2;
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

void setupLed(){
  analogWriteResolution(RED_1, RESOLUTION);
  analogWriteResolution(GREEN_1, RESOLUTION);
  analogWriteResolution(BLUE_1, RESOLUTION);

  analogWriteResolution(RED_2, RESOLUTION);
  analogWriteResolution(GREEN_2, RESOLUTION);
  analogWriteResolution(BLUE_2, RESOLUTION);
}

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
      analogWrite(RED_1, substringHexToInt(actionString, 1, 3));
      analogWrite(GREEN_1, substringHexToInt(actionString, 3, 5));
      analogWrite(BLUE_1, substringHexToInt(actionString, 5, 7));

      analogWrite(RED_2, substringHexToInt(actionString, 7, 9));
      analogWrite(GREEN_2, substringHexToInt(actionString, 9, 11));
      analogWrite(BLUE_2, substringHexToInt(actionString, 11, 13));
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
  setupLed();
  setupBluetooth();
}

void loop() {
  nextProgramStep();
  checkConnection();
}
