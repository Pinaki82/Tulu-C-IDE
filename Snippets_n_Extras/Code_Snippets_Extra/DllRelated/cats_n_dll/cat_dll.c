#include <stdio.h>

#include "cat_dll.h"


int func_cat_dll(
) {
  int i;
  for (i=1; i<=10; i+=1) {
   printf("%d. I am a cat..\n",i);
  }
  getchar();
  return 2*i;
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
