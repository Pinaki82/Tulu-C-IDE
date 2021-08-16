//---------------------------------------------------------------------------
//
// Name:
// Author:
// Created:
// Description:
//
//---------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if (defined 	__BUNDLED_LIBRARIES_STATIC_H__ )
       \n && ( defined(__DMC__) && !( defined(__TINYC__) || defined(__MINGW32__) || defined(_MSC_VER) ) )
	#include "..\include\bundled.libraries.static.h"
	#include <stdio.h>
  #include <stdlib.h>

 #else
	#if (defined __BUNDLED_LIBRARIES_DYNAMIC_H__ )
		#include <windows.h>                                //always include this.
		#include "..\include\bundled.libraries.dynamic.h"
		#include <stdio.h>
		#include <stdlib.h>
                        /*Include other headers*/
 #endif
#endif
/* Digital Mars compiler only supports including windows.h and everything in the dll-body's '.c' file
and never in the '.h', but some compilers may recommend including windows.h in the dll-body's header part,
but does not generally reports an error if the order is altered.*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


double FuncA(double a, double b) {
   return a + b;
}

double FuncB(double a, double b) {
   return a - b;
}

