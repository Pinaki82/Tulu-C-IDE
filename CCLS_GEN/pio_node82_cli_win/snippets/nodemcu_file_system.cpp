// Last Change: 2023-02-19  Sunday: 03:38:41 PM
/*********
  Rui Santos
  Complete project details at https://RandomNerdTutorials.com/esp8266-nodemcu-vs-code-platformio-littlefs/
*********/

/*
  https://randomnerdtutorials.com/esp8266-nodemcu-vs-code-platformio-littlefs/
  https://randomnerdtutorials.com/install-esp8266-nodemcu-littlefs-arduino/
  https://community.platformio.org/t/upload-file-system-image/14383/3
  Create a folder 'data' alongside the PlatformIO project file platformio.ini.
  Create a text file (e.g. text.txt) inside that 'data' folder.
  Upload:
  pio run -t uploadfs
  or
  pio run -t buildfs
*/

#include <Arduino.h>
#include "LittleFS.h"

void setup() {
  Serial.begin(9600);

  if(!LittleFS.begin()) {
    Serial.println("An Error has occurred while mounting LittleFS");
    return;
  }

  File file = LittleFS.open("/text.txt", "r");

  if(!file) {
    Serial.println("Failed to open file for reading");
    return;
  }

  Serial.println("File Content:");

  while(file.available()) {
    Serial.write(file.read());
  }

  file.close();
}

void loop() {
}
