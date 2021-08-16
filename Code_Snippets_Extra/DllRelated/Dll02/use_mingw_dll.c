#include <stdio.h>
#include "mingw_dll.h"

int main() {
  char              str[21];
  struct STRUCT_DLL S;
  int               i;

  S.count_int       = 10;
  S.ints            = malloc(sizeof(int) * 10);

  for (i=0; i<10; i++) {
    S.ints[i] = i;
  }


  func_dll(42, str, &S);

  printf("str: %s\n", str);

}
//Using the DLL
/* It is compiled like so:

gcc use_mingw_dll.c mingw_dll.dll -o use_mingw_dll
*/
