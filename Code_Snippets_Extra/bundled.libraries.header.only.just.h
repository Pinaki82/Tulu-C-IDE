#ifndef __BUNDLED_LIBRARIES_HEADER_ONLY_JUST_H__
#define __BUNDLED_LIBRARIES_HEADER_ONLY_JUST_H__

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C"
{
#endif

double FuncA(double a, double b); //your functions prototype declaration //use this as: z=FuncA(x,y);
double FuncB(double a, double b); //your functions prototype declaration //use this as: o=FuncB(m,n);

#ifdef __cplusplus
}
#endif

#endif // __BUNDLED_LIBRARIES_HEADER_ONLY_JUST_H__
	   //"bundled.libraries.header.only.just.h"
	  //write these for your reference.

//write your functions definitions here.
double FuncA(double a, double b) {
   return a + b;
}

double FuncB(double a, double b) {
   return a - b;
}

