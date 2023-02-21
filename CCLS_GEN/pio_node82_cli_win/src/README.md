1. Simple LED Blink and message output via Serial Monitor

```cpp
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
```

2. Basic web-server

```cpp
/*
  https://github.com/esp8266/Arduino/blob/master/libraries/ESP8266WebServer/examples/AdvancedWebServer/AdvancedWebServer.ino
  https://lastminuteengineers.com/creating-esp8266-web-server-arduino-ide/
  https://randomnerdtutorials.com/projects-esp8266/
*/
/*
   Copyright (c) 2015, Majenko Technologies
   All rights reserved.

   Redistribution and use in source and binary forms, with or without modification,
   are permitted provided that the following conditions are met:

 * * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.

 * * Redistributions in binary form must reproduce the above copyright notice, this
     list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

 * * Neither the name of Majenko Technologies nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
   ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
   ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <StreamString.h>

#ifndef STASSID
  #define STASSID "your-ssid"
  #define STAPSK "your-password"
#endif

const char *ssid = STASSID;
const char *password = STAPSK;

ESP8266WebServer server(80);

const int led = 13;

void handleRoot() {
  digitalWrite(led, 1);
  int sec = millis() / 1000;
  int min = sec / 60;
  int hr = min / 60;
  StreamString temp;
  temp.reserve(500);  // Preallocate a large chunk to avoid memory fragmentation
  temp.printf("\
<html>\
  <head>\
    <meta http-equiv='refresh' content='5'/>\
    <title>ESP8266 Demo</title>\
    <style>\
      body { background-color: #cccccc; font-family: Arial, Helvetica, Sans-Serif; Color: #000088; }\
    </style>\
  </head>\
  <body>\
    <h1>Hello from ESP8266!</h1>\
    <p>Uptime: %02d:%02d:%02d</p>\
    <img src=\"/test.svg\" />\
  </body>\
</html>",
              hr, min % 60, sec % 60);
  server.send(200, "text/html", temp.c_str());
  digitalWrite(led, 0);
}

void handleNotFound() {
  digitalWrite(led, 1);
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";

  for(uint8_t i = 0; i < server.args(); i++) {
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }

  server.send(404, "text/plain", message);
  digitalWrite(led, 0);
}

void drawGraph() {
  String out;
  out.reserve(2600);
  char temp[70];
  out += "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"400\" height=\"150\">\n";
  out += "<rect width=\"400\" height=\"150\" fill=\"rgb(250, 230, 210)\" stroke-width=\"1\" stroke=\"rgb(0, 0, 0)\" />\n";
  out += "<g stroke=\"black\">\n";
  int y = rand() % 130;

  for(int x = 10; x < 390; x += 10) {
    int y2 = rand() % 130;
    sprintf(temp, "<line x1=\"%d\" y1=\"%d\" x2=\"%d\" y2=\"%d\" stroke-width=\"1\" />\n", x, 140 - y, x + 10, 140 - y2);
    out += temp;
    y = y2;
  }

  out += "</g>\n</svg>\n";
  server.send(200, "image/svg+xml", out);
}

void setup(void) {
  pinMode(led, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  if(MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/", handleRoot);
  server.on("/test.svg", drawGraph);
  server.on("/inline", []() {
    server.send(200, "text/plain", "this works as well");
  });
  server.onNotFound(handleNotFound);
  server.begin();
  Serial.println("HTTP server started");
}

void loop(void) {
  server.handleClient();
  MDNS.update();
}
```

3. Basic user input using the `String` data type and `Serial.readString()`

```cpp
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
```

4. Reading user input 'byte by byte' from the Serial Monitor using `Serial.read()` [sort of `scanf()`] with buffer overflow prevention

```cpp
// Last Change: 2023-02-19  Sunday: 01:46:51 PM
// https://www.programmingelectronics.com/serial-read/

#include "HardwareSerial.h"
#include <Arduino.h>

// Suggested readings:
// https://www.circuitbasics.com/how-to-read-user-input-from-the-arduino-serial-monitor/
// https://www.tutorialspoint.com/arduino/arduino_strings.htm
// http://www.gammon.com.au/serial

const unsigned int MAX_MESSAGE_LENGTH = 12;

void setup() {
  Serial.begin(9600);
}

void loop() {
  //Check to see if anything is available in the serial receive buffer
  while(Serial.available() > 0) {
    //Create a place to hold the incoming message
    static char message[MAX_MESSAGE_LENGTH];
    static unsigned int message_pos = 0;
    //Read the next available byte in the serial receive buffer
    char inByte = Serial.read();

    //Message coming in (check not terminating character) and guard for over message size
    if(inByte != '\n' && (message_pos < MAX_MESSAGE_LENGTH - 1)) {
      //Add the incoming byte to our message
      message[message_pos] = inByte;
      message_pos++;
    }

    //Full message received...
    else {
      //Add null character to string
      message[message_pos] = '\0';
      //Print the message (or do other things)
      Serial.println(message);
      Serial.println("\n");
      //Reset for the next message
      message_pos = 0;
    }
  }
}
```

5. File upload and file content reading using LittleFS

```cpp
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
```

> Add the following lines to `platformio.ini`.

```ini
board_build.filesystem = littlefs
```

> `platformio.ini` should look somewhat like this:

```ini
[env:nodemcuv2]
platform = espressif8266
board = nodemcuv2
framework = arduino
upload_protocol = esptool
board_build.filesystem = littlefs
...
...
...
```

6. Generate Random Numbers at one-second intervals.

```cpp
// Last Change: 2023-02-21  Tuesday: 02:31:38 PM
#include <Arduino.h>
#include "HardwareSerial.h"
#include <stdlib.h>
#include <time.h>

#define RAND_MAX 10 /* generates better random no */ /*gcc-Warning: RAND_MAX re-defined*/

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  Serial.println("----------------\n");
  /*
    Declare variable to hold seconds on clock.
  */
  time_t seconds;
  /*
    Get value from system clock and
    place in seconds variable.
  */
  time(&seconds);
  /*
    Convert seconds to an unsigned
    integer.
  */
  srand((unsigned int) seconds);
  /* Simple "srand()" seed: just use "time()" */
  unsigned int iseed = (unsigned int)time(NULL);
  //srand(iseed);
  srand((iseed + (unsigned int)(1 + (int)(10.0 * rand() / (RAND_MAX + 1.0)))) / 2);  /* generates better random no */
  /* Now generate 5 pseudo-random numbers and print the last one */
  int i = 0, j = 0 /* generates better random no */ ;

  for(i = 0; i < 5; i++) {
    rand();
    rand();
    rand();
    j = 1 + (int)(10.0 * rand() / (RAND_MAX + 1.0));  /* generates better random no */
  }

  delay(1000); // 1 seconds
  Serial.println(j);
}
```

7. Generate random numbers using a header (1. A Range-based function and 2. a function that generates a random number between 8 to 10 digits).

```cpp
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
```

`noderand.h`:

```c
// Last Change: 2023-02-21  Tuesday: 08:21:27 PM
#ifndef __NODERAND_H__
#define __NODERAND_H__

#ifdef __cplusplus
extern "C" {
#endif

#define RAND_MAX 10 /* generates better random no */ /*gcc-Warning: RAND_MAX re-defined*/
unsigned int rand_10(); // generates 8/9/10 digit randon numbers
int rand_range(int *size, int *low); //use it as: a_variable=rand_range(&upper_range, &lower_range);
//you will get the returned value as your generated random number.

#ifdef __cplusplus
}
#endif

#endif // __NODERAND_H__

/*
  Header: stdio.h
  Reason: standard Input/Output
  Header: stdlib.h
  Reason: For functions rand and srand
  Header: time.h
  Reason: Required for the function time, and for data type time_t
*/
#include <Arduino.h>
#include "HardwareSerial.h"
#include <stdlib.h>
#include <time.h>

unsigned int rand_10() {
  /*
    Declare a variable to hold seconds in the clock.
  */
  time_t seconds;
  /*
    Get the value from the system clock and store
    it in the seconds variable.
  */
  time(&seconds);
  /*
    Convert seconds to an unsigned
    integer.
  */
  srand((unsigned int) seconds);
  /* Simple "srand()" seed: just use "time()" */
  unsigned int iseed = (unsigned int)time(NULL);
  //srand(iseed);
  srand((iseed + (unsigned int)(1 + (int)(10.0 * rand() / (RAND_MAX + 1.0)))) / 2);  /* generates better random no */
  /* Now generate 5 pseudo-random numbers and print the last one */
  int i = 0, j = 0;

  for(i = 0; i < 5; i++) {
    rand();
    rand();
    rand();
    j = 1 + (int)(10.0 * rand() / (RAND_MAX + 1.0));  /* generates better random no */
  }

  return j;
}

int rand_range(int *size, int *low) {
  int high = *size;
  /* size, here we set the maximum value of the generated random number, i.g, 25 etc. */
  /*
    These constants define our upper
    and our lower bounds. The random numbers
    will always be between these values, inclusive.
  */
  time_t seconds;
  time(&seconds);
  srand((unsigned int) seconds);
  unsigned int iseed = (unsigned int)time(NULL);
  //srand(iseed);
  srand((iseed + (unsigned int)(1 + (int)(10.0 * rand() / (RAND_MAX + 1.0)))) / 2);  /* generates better random no */
  int generated;

  for(int i = 0; i < 5; i++) {
    generated = rand() % (high - *low + 1) + *low;
  }

  /*
    Returns result.
  */
  return (generated);
  /*
    LOGIC:
    For any two integers, say a and b, a % b is between 0 and b - 1,
    inclusive. With this in mind, the expression rand() % high + 1 would generate
    a number between 1 and high, inclusive, where high is less than or equal to RAND_MAX,
    a constant defined by the compiler.
    To place a lower bound in replacement of 1 on that result, we allow the
    program to generate a random number between 0 and (high - low + 1) + low.
  */
}
```

Sample [PlatformIO](https://platformio.org/) project configuration (always `platformio.ini`):

[PlatformIO](https://platformio.org/)

PlatformIO [Desktop IDE integration](https://platformio.org/install/integration): [Vim &mdash; PlatformIO latest documentation](https://docs.platformio.org/en/latest/integration/ide/vim.html)

[PlatformIO-CLI](https://platformio.org/install/cli)

```ini
; ESP8266 NodeMCUv2 (clone/2MB with CH340G USB To TTL/Serial)
; PlatformIO Project Configuration File
;
;   Build options: build flags, source filter
;   Upload options: custom upload port, speed and extra flags
;   Library options: dependencies, extra library storages
;   Advanced options: extra scripting
;
; Please visit documentation for the other options and examples
; https://docs.platformio.org/page/projectconf.html

; https://lastminuteengineers.com/creating-esp8266-web-server-arduino-ide/
; https://github.com/esp8266/Arduino/blob/master/libraries/ESP8266WebServer/examples/AdvancedWebServer/AdvancedWebServer.ino

; pio project init --ide vim --board nodemcuv2

[env:nodemcuv2]
platform = espressif8266
board = nodemcuv2
framework = arduino
upload_protocol = esptool
; board_build.filesystem = littlefs
; LittleFS File System for NodeMCU ESP8266
; https://randomnerdtutorials.com/esp8266-nodemcu-vs-code-platformio-littlefs/
platform_packages =
    platformio/framework-arduinoespressif8266 @ https://github.com/esp8266/Arduino.git
; https://community.platformio.org/t/esp8266wifi-library-not-found/7475
; https://github.com/tzapu/WiFiManager
; https://github.com/esp8266/Arduino
; https://docs.platformio.org/en/stable/platforms/espressif8266.html#using-arduino-framework-with-staging-version
; https://github.com/platformio/platform-espressif8266/tree/master/examples/arduino-webserver?utm_source=platformio.org&utm_medium=docs

monitor_port = COM4
; monitor_speed = 115200
; upload_port = COM4
lib_deps =
    ; ESP8266WebServer @ ^1.0
    ; werecatf/PCF8574_ESP@^1.0.10
    ; marcoschwartz/LiquidCrystal_I2C@^1.1.4
    ; arduino-libraries/NTPClient
    ; bblanchon/ArduinoJson@^6.17.2
    ; paulstoffregen/Time@^1.6.1
    ; links2004/WebSockets@^2.3.6
    ; gmag11/NtpClientLib@^3.0.2-beta
    ; knolleary/PubSubClient@^2.8
    ; paulstoffregen/OneWire@^2.3.6
    ; milesburton/DallasTemperature@^3.9.1
    ; adafruit/Adafruit BME280 Library@^2.2.1
    ; adafruit/Adafruit BusIO@^1.9.8
    ; adafruit/Adafruit GFX Library@^1.10.12
    ; adafruit/Adafruit Unified Sensor@^1.1.4
    ; adafruit/Adafruit ILI9341@^1.5.10
    ; adafruit/DHT sensor library@^1.4.3

lib_ignore =
    WiFi101
    ; TinyWireM

build_unflags =
    ; -std=gnu++11

build_flags =
    ; -std=c++17
    -D PIO_FRAMEWORK_ARDUINO_LWIP2_HIGHER_BANDWIDTH
    -DDEBUG_ESP_PORT=Serial
    -DDEBUG_ESP_OTA
; https://community.platformio.org/t/esp8266webserver-impl-h-compilation-error/24751/9

; Final Solution
; https://github.com/esp8266/Arduino/tree/master/libraries/ESP8266WebServer
; https://github.com/esp8266/Arduino/blob/master/libraries/ESP8266WebServer/examples/AdvancedWebServer/AdvancedWebServer.ino
```
