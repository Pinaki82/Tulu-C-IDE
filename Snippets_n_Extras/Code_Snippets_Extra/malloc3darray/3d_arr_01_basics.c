// Last Change: 2016-01-19  Tuesday: 09:45:52 PM
#include <errno.h>
#include <stdint.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  int a[3][4][2]= {
    {
      {2, 4},
      {7, 8},
      {3, 4},
      {5, 6},
    },
    {
      {7, 6},
      {3, 4},
      {5, 3},
      {2, 3},
    },
    {
      {8, 9},
      {7, 2},
      {3, 4},
      {5, 1}
    }
  };
  printf("%u\n", a);
  printf("%u\n", *a);
  printf("%u\n", **a);
  printf("%u\n", * **a);
  printf("%u\n", a+1);
  printf("%u\n", *a+1);
  printf("%u\n", **a+1);
  printf("%u\n", * **a+1);
  system("PAUSE");
  return EXIT_SUCCESS;
}

/*
2293232
2293232
2293232
2
2293264
2293240
2293236
3
Press any key to continue . . .
*/


