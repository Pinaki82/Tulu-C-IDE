// Last Change: 2013-05-29 01:56:16
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "StaticLib.h"

#ifdef  _MSC_VER
#include "resource.h"
#endif

int main(void) {
  double Ab, bB, Cc1;
  printf("Ab=?\n");
  scanf("%lf", &Ab);
  printf("bB=?\n");
  scanf("%lf", &bB);
  Cc1=FuncA(Ab,bB);
  printf("\nCc1=%lf\n",Cc1);
  Cc1=FuncB(Ab,bB);
  printf("\nCc1=%lf\n",Cc1);
  system("PAUSE");
  return EXIT_SUCCESS;
}

