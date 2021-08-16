//---------------------------------------------------------------------------
//
// Name:
// Author:
// Created:
// Description:
//
//---------------------------------------------------------------------------
#ifndef __BUNDLED_LIBRARIES_STATIC_H__
#define __BUNDLED_LIBRARIES_STATIC_H__

#if !defined(__DMC__) /*Don't include <windows.h> if you are creating a static lib using Digital Mars.*/
#include <windows.h> /*any win32 GUI library in DMC will not work for a static library, if needed create dll.*/
#endif
#if ( defined(__TINYC__) || defined(__MINGW32__) || defined(_MSC_VER) ) && ! defined(__DMC__)
  #include <stdio.h>
  #include <stdlib.h>
				/*Library Inclusion Step:
				include necessary standard/3-rd-party libraries to create the library header.*/  
#endif
//---------------------------------------------------------------------------

#ifdef __cplusplus
extern "C"
{
#endif

double FuncA(double a, double b); //your functions prototype declaration //use this as: z=FuncA(x,y);
double FuncB(double a, double b); //your functions prototype declaration //use this as: o=FuncB(m,n);

#ifdef __cplusplus
}
#endif

#endif // __BUNDLED_LIBRARIES_STATIC_H__
	   //"bundled.libraries.static.h"
	  //write these for your reference.

