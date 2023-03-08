/*
   =====================================================================================

         Filename:  serialInput.h

      Description: Reads a string of chars until the user hits the Enter key.


          Version:  1.0
          Created:  2023/MAR/08
         Revision:  none
         Compiler:  Arduino-CLI/PlatformIO-CORE

         Based on: An OpenAI chatGPT response
     Organization:
          Licence: MIT-0

  Usage:

  #include <Arduino.h>
  String userInput = readSerialInput();
  Serial.println(userInput);

   =====================================================================================
*/

#ifndef __SERIALINPUT_H__
#define __SERIALINPUT_H__
/* write defenitions as: __BLANK_HEADER_H__
   note double_underscore at the start and end */
/*----------------------------------------------------------------------------*/
/*
   Put Non-functions like stuffs, like:
   Global Variables and #define etc. here
*/
/*----------------------------------------------------------------------------*/

#include <Arduino.h>
/* #include more headers you need */
/*----------------------------------------------------------------------------*/

#ifdef __cplusplus
extern "C" {
#endif

String readSerialInput(); //Usage: String userInput = readSerialInput();

//put your functions prototype declarations here //write guides as:- use this as: z=FuncA(x,y);
//functions prototype declarations
//functions prototype declarations

#ifdef __cplusplus
}
#endif

#endif // __SERIALINPUT_H__
// __BLANK_HEADER_H__
//"serialInput.h"
//write these for your reference.

/*----------------------------------------------------------------------------*/

/*
  write your functions definitions below (if needed, if its a header-only file).
  These are the real codes.
*/

/*----------------------------------------------------------------------------*/

String readSerialInput() { //Usage: String userInput = readSerialInput();
  String inputString = "";         // a String to hold incoming data
  bool stringComplete = false;     // whether the string is complete

  while(!stringComplete) {
    if(Serial.available()) {
      char c = Serial.read();     // read the next character

      if(c == '\n') {
        stringComplete = true;    // set the string as complete
      }

      else {
        inputString += c;         // add the character to the string
      }
    }
  }

  return inputString;
}


/*
  ==============================================================================
  OpenAI ChatGPT:
  ==============================================================================
  This header file defines the "readSerialInput" function,
  which returns a String variable containing
  the user input read from the serial port.
  The function uses a while loop to
  continually check for input until a
  newline character ('\n') is received.
  It then sets the stringComplete
  flag and returns the inputString variable.

  To use this header file, you would include it in
  your main sketch
  using the #include "serialInput.h" statement, and then
  call the readSerialInput() function wherever you need to read
  input from the serial port.
  Here's an example main sketch that uses
  the "serialInput.h" header file:
*/

/*
  #include <Arduino.h>

  #include "serialInput.h"

  void setup() {
    Serial.begin(9600);
  }

  void loop() {
    String userInput = readSerialInput();
    Serial.println("\n");

    if(userInput.length() > 0) {
      Serial.println("User input: " + userInput);
      //or, Serial.println(userInput);
    }

    Serial.println("\n");
  }
*/

/*
  In this example, we include
  the "serialInput.h" header file,
  initialize the serial communication
  in the setup() function, and then
  call the readSerialInput() function
  in the loop() function to
  read input from the serial port.
  We then check if the length of
  the user input string is
  greater than zero to make sure
  we actually received input before
  printing it to the serial port.
*/

