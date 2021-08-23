//---------------------------------------------------------------------------
//
// Name:
// Author:
// Created:
// Description:
//
//---------------------------------------------------------------------------
#include "../include/StaticLib.h"

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if defined(__DMC__) && !( defined(__TINYC__) || defined(__MINGW32__) || defined(_MSC_VER) )
  /*Don't include <windows.h> if you are creating a static lib using Digital Mars.
  any win32 GUI library will not work for a static library, if needed create dll.*/
  #include <stdio.h>
  #include <stdlib.h>
#endif

/*This is an irritating thing of the Digital Mars compiler, they include everything in the library-body's '.c' file
and never in the '.h'*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


double FuncA(double a, double b) {
   return a + b;
}

double FuncB(double a, double b) {
   return a - b;
}

