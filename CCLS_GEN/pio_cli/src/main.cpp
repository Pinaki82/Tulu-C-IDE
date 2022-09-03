// Last Change: 2022-09-02  Friday: 11:00:16 AM
/**
   Blink

   Turns on an off an LED sequentially at
   an interval of one second.
*/
#include <Arduino.h>

#ifndef LED_BUILTIN
  #define LED_BUILTIN 13
#endif

void setup() {
  // initialize LED digital pin as an output.
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // turn the LED on (HIGH is the voltage level)
  digitalWrite(LED_BUILTIN, HIGH);
  // wait for a second
  delay(1000);
  // turn the LED off by making the voltage LOW
  digitalWrite(LED_BUILTIN, LOW);
  // wait for a second
  delay(1000);
}
