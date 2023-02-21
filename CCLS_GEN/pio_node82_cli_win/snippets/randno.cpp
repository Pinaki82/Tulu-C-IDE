// Last Change: 2023-02-21  Tuesday: 06:24:54 PM
#include <Arduino.h>
#include "HardwareSerial.h"
#include <stdlib.h>
#include <time.h>
#include "../include/noderand.h"

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  int size = 25, lower_range = 9; // a random no. between 9 to 25
  int rand_ret = 0;
  int rand_ret2 = 0;
  rand_ret = rand_10();
  rand_ret2 = rand_range(&size, &lower_range);
  delay(1000); // 1 second(s)
  Serial.println(rand_ret);
  Serial.println(rand_ret2);
}

