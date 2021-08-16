// Last Change: 2013-05-29 23:26:39
/* Initializing pointers at the time of declaration */
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef  _MSC_VER
#include "resource.h"
#endif

int main(void) {
  int temp001=7, *my_test_pointer=&temp001, ik=0; /* Initialization of pointer */
  /* or later you may wish to write
    my_test_pointer=&temp001; */

  /* From C_programming_wikibooks read section
  "28.1.1 Pointers" for details */

  printf("initialized pointer is %d\n",*my_test_pointer);
  system("PAUSE");
  return EXIT_SUCCESS;
}

