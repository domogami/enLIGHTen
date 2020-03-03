#define BUTTON_PIN 18  //D18 is the button pin
#define COUNT_LOW 0
#define COUNT_HIGH 8888
#define COUNT_MID 4444
#define SERVO_CONTROL_PIN 2  //D2 is the servo control

#define TIMER_WIDTH 16
#include "esp32-hal-ledc.h"


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
  if (button1.pressed) {
      if(0 == switch_position){
        Serial.printf("Turning switch on");
        turn_on();
        //switch_position = 1;
        button1.pressed = false;
      }
  }
      
   if (button1.pressed) {
      if(1 == switch_position){
        Serial.printf("Turning switch off");
        turn_off();
        //switch_position = 0;
        button1.pressed = false;
      }
  }
}
