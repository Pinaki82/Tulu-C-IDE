#ifndef __DLLTEST_H__
#define __DLLTEST_H__

#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

#ifdef BUILD_DLL
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT __declspec(dllimport)
#endif

#ifdef __cplusplus
extern "C"
{
#endif

void  __declspec(dllexport)  NumberList();
void  __declspec(dllexport)  LetterList();

#ifdef __cplusplus
}
#endif

#endif // __MAIN_H__

