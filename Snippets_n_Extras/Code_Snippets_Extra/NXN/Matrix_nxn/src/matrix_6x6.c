// Last Change: 2013-07-03 13:37:00
#include <errno.h>
#include <stdlib.h>
#include "matrix_nxn.h"
#define N 6
int main(void) {
  int mat[N][N], det_value;
  int i, j, n=N;
  /* ///////// deal with malloc and 2d array allocation /////// */
  int **mat2;
  mat2=(int **)malloc((size_t)N * sizeof(int *));
  for(i=0; i<=N-1 ; i++) {
    for(j=0; j<=N-1 ; j++) {
      mat2[i]=(int *)malloc((size_t)N * sizeof(int));
    }
  }  /* //////////////// */
  printf("Input the %dx%d determinant:\n",N,N);
  for(i=0; i<=N-1; i++) {
    for(j=0; j<=N-1; j++) {
      scanf("%d",&mat[i][j]);
    }
  }
  /* ///////// exchange elements /////// */
  for(i=0; i<=N-1 ; i++) {
    for(j=0; j<=N-1 ; j++) {
      *(*(mat2+i)+j)=*(*mat+i*N+j);
    }
  }  /* //////////////// */

  printf("----------------------------\n");
  det_value=matrix(mat2,n);

  printf("determinant value of the input matrix= %d\n",det_value);
  for(i=0; i<=N-1 ; i++) {
    for(j=0; j<=N-1 ; j++) {
      free(mat2[i]);
      mat2[i]=NULL;
    }
  }
  free(mat2);
  mat2=NULL;
  system("PAUSE");
  return 0;
}

