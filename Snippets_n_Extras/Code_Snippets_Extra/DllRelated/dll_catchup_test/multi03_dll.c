#include <stdio.h>

#include "multi03_dll.h"


DLLIMPORT void func_multi03_dll(
) {
  int i;
  for (i=1; i<=3; i+=1) {
   printf("%d. I am in multi03..\n",i);
  }
  getchar();
}
/*
 This file can be turned into a DLL using the -shared option:

gcc -Wall -shared mingw_dll.c -o mingw_dll.dll
*/
/*
Compiler:
-DBUILDING_DLL=1
C++ Compiler:
-DBUILDING_DLL=1
Linker:
--no-export-all-symbols
-Wl,--add-stdcall-alias
*/
