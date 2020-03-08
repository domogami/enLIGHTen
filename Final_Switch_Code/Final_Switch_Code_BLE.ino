///////////////BLE includes
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
/////////////////////////////////

#define BUTTON_PIN 18  //D18 is the button pin
#define COUNT_LOW 0
#define COUNT_HIGH 8888
#define COUNT_MID 4444
#define SERVO_CONTROL_PIN 2  //D2 is the servo control

#define TIMER_WIDTH 16
#include "esp32-hal-ledc.h"

//BLE code/////////////////////////
BLEServer *pServer = NULL;
BLECharacteristic * pTxCharacteristic;
bool deviceConnected = false;
bool oldDeviceConnected = false;
uint8_t txValue = 0;

// See the following for generating UUIDs:
// https://www.uuidgenerator.net/

#define SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
//#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"


std::string thisVal;


class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};

class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
      thisVal = rxValue;
      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
          Serial.print(rxValue[i]);

        Serial.println();
        Serial.println("*********");
      }
    }
};
///////////////////////////////////////////////


struct Button {
  const uint8_t PIN;
  uint32_t numberKeyPresses;
  bool pressed;
};


Button button1 = {BUTTON_PIN, 0, false};
bool switch_position = 0; //0 means switch is down, 1 means switch is up

void IRAM_ATTR isr() {
  button1.pressed = true;
  delay(30);
}

void setup() {
  Serial.begin(115200);
  ////BLE/////////////////
  // Create the BLE Device
  BLEDevice::init("UART Service");

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  pTxCharacteristic = pService->createCharacteristic(
                    CHARACTERISTIC_UUID_TX,
                    BLECharacteristic::PROPERTY_NOTIFY
                  );
                      
  pTxCharacteristic->addDescriptor(new BLE2902());

  BLECharacteristic * pRxCharacteristic = pService->createCharacteristic(
                       CHARACTERISTIC_UUID_RX,
                      BLECharacteristic::PROPERTY_WRITE
                    );

  pRxCharacteristic->setCallbacks(new MyCallbacks());

  // Start the service
  pService->start();

  // Start advertising
  pServer->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify...");
  /////////////////////////////////////////////////////////////
  pinMode(button1.PIN, INPUT_PULLUP);
  attachInterrupt(button1.PIN, isr, FALLING);

  ledcSetup(1, 50, TIMER_WIDTH); // channel 1, 50 Hz, 16-bit width
  ledcAttachPin(SERVO_CONTROL_PIN, 1);   // GPIO 22 assigned to channel 1
}


void turn_on(){
  for (int i=COUNT_MID ; i < COUNT_HIGH - 2700 ; i=i+400){
      ledcWrite(1, i);       // sweep servo 1
      delay(100);
   }
   ledcWrite(1, COUNT_MID);
   switch_position = 1;
}

void turn_off(){
 for (int i=COUNT_MID ; i > COUNT_LOW + 2700 ; i=i-400){
      ledcWrite(1, i);       // sweep servo 1
      delay(100);
   }
   ledcWrite(1, COUNT_MID);
   switch_position = 0;
}


void loop() {
  if (deviceConnected) {
  if (button1.pressed) {
      if(0 == switch_position){
        //Serial.printf("Turning switch on");
        turn_on();
        switch_position = 1;
        button1.pressed = false;
        //Here, you would need to send a signal to the pi that the switch is now on////////////
        pTxCharacteristic->setValue(&txValue, 1);
        pTxCharacteristic->notify();
        txValue++;
        delay(10); // bluetooth stack will go into congestion, if too many packets are sent//////
      }
      else {
        //Serial.printf("Turning switch off");
        turn_off();
        switch_position = 0;
        button1.pressed = false;
        //here, send a signal that the switch is now off/////////////////
        pTxCharacteristic->setValue(&txValue, 1);
        pTxCharacteristic->notify();
        txValue++;
        delay(10); // bluetooth stack will go into congestion, if too many packets are sent//////
      }
  }
  if(thisVal.length() == 2){
    turn_off();
    switch_position = 0;
    button1.pressed = false;
    thisVal = "0";
  }
  if(thisVal.length() == 3){
    turn_on();
    switch_position = 1;
    button1.pressed = false;
    thisVal = "0";
  }
  }
  // disconnecting
    if (!deviceConnected) {
        delay(500); // give the bluetooth stack the chance to get things ready
        pServer->startAdvertising(); // restart advertising
        Serial.println("start advertising");
    }
    // connecting
}
