#include <stdio.h>
#include "cat_dll.h"

int main() {
  int k;
  k=func_cat_dll();
  printf("returned from cat_dll= %d\n", k);
  getchar();
  return 0;
}
//Using the DLL
/* It is compiled like so:

gcc use_mingw_dll.c mingw_dll.dll -o use_mingw_dll
*/
/*
Linker: Output/MingW/libcats_n_dll.a
*/
