// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T
// https://www.luisllamas.es/en/esp32-pwm/
// https://espressif-docs.readthedocs-hosted.com/projects/arduino-esp32/en/latest/api/ledc.html
// https://randomnerdtutorials.com/esp32-web-bluetooth/

#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

BLEServer* pServer = NULL;
BLECharacteristic* pBallCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;

#define SERVICE_UUID        "26baf7e5-dc66-494d-af84-1e5a9074ff46"
#define BALL_CHARACTERISTIC_UUID "85d17ec3-1385-4b86-b0af-c473d77a45b3"

String testprogramm = "LFF000000FF00;D1000;L00FF000000FF;D2000;L0000FFFF0000;D1500;";
int idx;
int nextIdx;

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
  if (deviceConnected) {
    pBallCharacteristic->setValue(actionString);
    pBallCharacteristic->notify();
    Serial.print("New value notified: ");
    Serial.println(actionString);
  }
  switch (actionString.charAt(0)){
    case 'L': // LED
//      setLed(1, actionString.substring(1,7));
//      setLed(2, actionString.substring(7,13));
      break;
    case 'D': // delay
//      Serial.print("Waiting ");
//      Serial.print(actionString.substring(1));
//      Serial.print(" ms");
//      Serial.println();
      break;
  }
}

void setup() {
  Serial.begin(115200);

  BLEDevice::init("Ball 1");
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  
  BLEService *pService = pServer->createService(SERVICE_UUID);

  pBallCharacteristic = pService->createCharacteristic(
                      BALL_CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_NOTIFY
                    );

  pBallCharacteristic->addDescriptor(new BLE2902());

  pService->start();

  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  BLEDevice::startAdvertising();

}

void loop() {
  nextIdx = idx + testprogramm.substring(idx).indexOf(";") + 1;
  performAction(testprogramm.substring(idx, nextIdx-1));
  idx = nextIdx;
  if(idx >= testprogramm.length()){
    idx = 0;
  }

  delay(1000);

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
