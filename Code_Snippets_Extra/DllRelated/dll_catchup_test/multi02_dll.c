#include <stdio.h>

#include "multi02_dll.h"


DLLIMPORT void func_multi02_dll(
) {
  int i;
  for (i=1; i<=3; i+=1) {
   printf("%d. I am in multi02..\n",i);
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
