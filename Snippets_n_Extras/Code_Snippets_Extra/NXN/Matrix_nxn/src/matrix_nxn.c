// Last Change: 2013-07-03 13:28:19
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include "matrix_nxn.h"

int main(void) {
  int **mat, det_value;
  int i, j, n, row, col; /* n is the rank, i, j used in loops */
  /*  **mat is a 2D array, essentially a
       collection of some array (of pointers). */

  /*
   * * * * * * * * * * * * 2D way. * * * * * * * * * * * *
   * An example snippet of dynamic memory allocation for a 2D array.
   * Method 2: We'll have to simulate the 2D array (of pointers) with another pointer,
   * and this will be a pointer to a pointer.
   * The idea is to first create a one dimensional array of pointers (row basis),
   * and then,
   * for each array entry (each row's base address/pointers),
   * create another one dimensional array of pointers (column basis).
   *
   * NOTE: use it within the function you need, but don't create a
   * dedicated memory allocation function with it.
  */

  printf("input the rank of the matrix: ");
  scanf("%d", &n);
  printf("\n");
  row=n; col=n;

  mat = (int **)malloc((size_t)row *sizeof(int *));  /* memory allocation,
                                                            row basis */
  if(mat==NULL) {
    printf("\ndynamic memory allocation failed\n");
    system("PAUSE");
    exit(EXIT_FAILURE);
  }
  for(i=0; i<=row-1; i++) {
    mat[i]=(int *)malloc((size_t)col * sizeof(int));  /* memory allocation,
                                                            column basis */
    if(mat[i]==NULL) {
      printf("\ndynamic memory allocation failed\n");
      system("PAUSE");
      exit(EXIT_FAILURE);
    }
  }
  for(i = 0; i<=row-1; i++) {
    for(j = 0; j<=col-1; j++) {
      mat[i][j] = 0;  /* filling the entire array with a temporary number */
    }
  }


  printf("......input the elements........\n");
  for(i=0; i<=row-1; i++) {
    for(j=0; j<=col-1 ; j++) {
      scanf("%d",(*(mat+i)+j)); /* NOTE: you cannot use (mat+i*col+j) or
      any other pointer arithmetic. however you are allowed to perform
      &mat[i][j] or, (*(mat+i)+j) here. */
    }
  }

  /* /////////////////////////// */

  printf("----------------------------\n");
  det_value=matrix(mat,n);
  printf("determinant value of the input matrix= %d\n",det_value);
  for(i = 0; i<=row-1; i++) {
    free(mat[i]); /* very much essential */
    mat[i] = NULL;
  }
  free(mat); /* very much essential */
  mat = NULL;

  system("PAUSE");
  return 0;
}

