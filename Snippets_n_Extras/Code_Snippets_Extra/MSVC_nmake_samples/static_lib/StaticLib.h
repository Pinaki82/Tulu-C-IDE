//---------------------------------------------------------------------------
//
// Name:
// Author:
// Created:
// Description:
//
//---------------------------------------------------------------------------
#ifndef __STATICLIB_H__
#define __STATICLIB_H__

///////////////////////////////////////////////////////////////////////////////////////////////////////
#if !defined(__DMC__) /*Don't include <windows.h> if you are creating a static lib using Digital Mars.*/
#include <windows.h> /*any win32 GUI library in DMC will not work for a static library, if needed create dll.*/
#endif
#if ( defined(__TINYC__) || defined(__MINGW32__) || defined(_MSC_VER) ) && ! defined(__DMC__)
  #include <stdio.h>
  #include <stdlib.h>
#endif
/*Other than "Digital Mars compiler" most common IDEs recommend to include the standard headers in the library-body's '.h' section
and the '.c' file is left blank without attaching anything but just the library-header. DMC is mainly command-line based.*/
///////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef __cplusplus
extern "C"
{
#endif

double FuncA(double a, double b); //your functions prototype declaration //use this as: z=FuncA(x,y);
double FuncB(double a, double b); //your functions prototype declaration //use this as: o=FuncB(m,n);

#ifdef __cplusplus
}
#endif

#endif // __STATICLIB_H__
	   //"StaticLib.h"
	  //write these for your reference.

