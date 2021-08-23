#ifndef __DLLTEST_H__
#define __DLLTEST_H__

#include <stdio.h>
#include <stdlib.h>
// #include<strings.h> /* this header is not mandatory */
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

void DLL_EXPORT cat();
void DLL_EXPORT dog();

#ifdef __cplusplus
}
#endif

#endif // __DLLTEST_H__

