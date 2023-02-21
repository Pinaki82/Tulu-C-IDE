// Last Change: 2023-02-18  Saturday: 02:48:19 PM
#include "HardwareSerial.h"
#include "ets_sys.h"
#include "string.h"
#include <Arduino.h>
// https://www.circuitbasics.com/how-to-read-user-input-from-the-arduino-serial-monitor/
// https://www.programmingelectronics.com/serial-read/

char password[] = "ABCDEF";

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.println("Please enter your password: ");

  while(Serial.available() == 0) {
  }

  String input = Serial.readString();

  if(input == password) {
    Serial.println("Password correct");
    Serial.println("You typed:");
    Serial.println(input);
    Serial.println("Type something else.\n");

    while(Serial.available() == 0) {
    }

    input = Serial.readString();
    Serial.println("You typed:");
    Serial.println(input);
  }

  else {
    Serial.println("Password incorrect");
  }
}

