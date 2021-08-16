#include <stdio.h>
#include <stdlib.h>
#include "multi01_dll.h"
#include "multi02_dll.h"
#include "multi03_dll.h"

int main() {
  int k, nos, i;
  printf("input 1,2 or 3 to catch dll 1,2 or 3.. and 4 to exit.\n");
  scanf("%d",&nos);
  i=nos;
  
  switch(i){
   case 1:
      k=func_multi01_dll();
      printf("returned from multi01_dll= %d\n", k);
    break;
    
   case 2:
      func_multi02_dll();
    break;
    
   case 3:
      func_multi03_dll();
    break;
    
   case 4:
      return 0;
      system("exit");
    break;
  }
  
  getchar();
  return main();
}
//Using the DLL
/* It is compiled like so:

gcc use_mingw_dll.c mingw_dll.dll -o use_mingw_dll
*/
/*
Linker:
Output/MingW/libmulti01_dll.a
Output/MingW/libmulti02_dll.a
Output/MingW/libmulti03_dll.a
*/
