// Last Change: 2013-05-29 01:56:16
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "easy_dll.h"

#ifdef  _MSC_VER
#include "resource.h"
#endif

int main(void) {
  int Ab=0;
  Ab=func_multi01_dll();
  printf("\nreturned=%d\n",Ab);
  system("PAUSE");
  return EXIT_SUCCESS;
}

