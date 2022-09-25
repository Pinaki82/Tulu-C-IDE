// Last Change: 2013-06-30 13:05:54
#include <stdio.h>
#include <stdlib.h>
#include "perm_ptr2.h"
#define NROW 24 /*row. dimension of the permutation array. usually, factorial(col) */
#define NCOL 4 /*col. dimension of the permutation array*/
int main(void) {
  int i, j, n=NCOL; int final_arngd[NROW][NCOL];
  permut(n,*final_arngd);
  for(i=0; i<24; i++) {
    for(j=0; j<n; j++) {
      printf("%d ",*(*final_arngd+i*n+j));
    }
    printf("\n");
  }
  printf("\n");
  system("PAUSE");
  return 0;
}

