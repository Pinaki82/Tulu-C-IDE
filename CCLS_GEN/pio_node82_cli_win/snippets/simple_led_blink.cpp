// Last Change: 2023-02-18  Saturday: 01:25:12 PM
// https://randomnerdtutorials.com/vs-code-platformio-ide-esp32-esp8266-arduino/
// https://www.apdaga.com/2017/12/nodemcu-connect-to-arduino-ide-and-burn.html

#include <Arduino.h>

// #define ledPin 16
#define ledPin LED_BUILTIN // the built-in blue LED

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(ledPin, OUTPUT); // equiv. to pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(ledPin, LOW);
  Serial.println("LED is ON!!!");
  delay(3000); // 3 seconds
  digitalWrite(ledPin, HIGH);
  Serial.println("LED is OFF!!!");
  delay(3000);
}

