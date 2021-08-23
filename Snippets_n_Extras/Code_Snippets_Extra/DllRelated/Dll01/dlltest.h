#ifndef _DLLTEST_H_
#define _DLLTEST_H_

#include <iostream.h>
#include <stdio.h>
#include <windows.h>

extern "C" __declspec(dllexport) void NumberList();
extern "C" __declspec(dllexport) void LetterList();


#endif
//http://www.flipcode.com/archives/Creating_And_Using_DLLs.shtml
