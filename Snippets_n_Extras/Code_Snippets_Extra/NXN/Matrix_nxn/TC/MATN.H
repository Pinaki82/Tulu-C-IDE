// Last Change: 2013-07-03 02:34:36
#ifndef __MATN_H__
#define __MATN_H__

#include <errno.h> /* required */
#include <stdio.h> /* required */
#include <stdlib.h> /* required */

#ifdef __cplusplus
extern "C"
{
#endif

int matrix(int **matx, int n);  //

#ifdef __cplusplus
}
#endif

#endif

void permut_array(int n, int *final_arrangmnt);
void permut(int n, int **final_arngd);
void swap(int *x, int *y);
int next(int *v, int n);
void arranged(int n, int *v, int **final_arngd);

int x=0;
////////////////////////////////////////////////////////////////////////////////
int levi_civita(int *input_levi_civita, int n);  //use it as, signature=signature=levi_civita (permuation_set,N);
int factorial(int num);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int matrix(int **matx, int n) {
  int i, j, k=0; int **final_arngd;
  int det=0, *permuation_set, signature, det_per_step=1;
  /* ///////////////////////// */
  int row, col; /*  **final_arngd is a 2D array, essentially a
                                    collection of some array (of pointers).*/

  row=factorial(n); col=n; /* NOTE: row. dimension of the permutation array.
                             usually, factorial(col) */

  final_arngd = (int **)malloc((size_t)row *sizeof(int *));  /* memory allocation,
                                                            row basis */
  if(final_arngd==NULL) {
    printf("\ndynamic memory allocation failed\n");
    system("PAUSE");
    exit(EXIT_FAILURE);
  }
  for(i=0; i<=row-1; i++) {
    final_arngd[i]=(int *)malloc((size_t)col * sizeof(int));  /* memory allocation,
                                                            column basis */
    if(final_arngd[i]==NULL) {
      printf("\ndynamic memory allocation failed\n");
      system("PAUSE");
      exit(EXIT_FAILURE);
    }
  }
  for(i = 0; i<=row-1; i++) {
    for(j = 0; j<=col-1; j++) {
      final_arngd[i][j] = 0;  /* filling the entire array with a temporary number */
    }
  }

  /* ///////////////////////// */

  permuation_set = (int *)malloc((size_t)col * sizeof(int));
  if(permuation_set==NULL) {
    printf("dynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }
  for(i=0; i<=col-1 ; i++) {
    permuation_set[i]=0;
  }

  /* ///////////////////////// */
  permut(col,final_arngd);
  for(i=0; i<=row-1; i++) {
    for(j=0; j<=col-1; j++) {
      *(permuation_set+j)=*(*(final_arngd+i)+j);
    }
    signature=levi_civita(permuation_set,col);
    for(j=0; j<=col-1; j++) {
      det_per_step=det_per_step **(*(matx+j)+k+permuation_set[j]-1); /* NOTE: logic */
    }
    det_per_step=signature*det_per_step;
    det=det+det_per_step;
    det_per_step=1;
    k=0;
  }

  for(i = 0; i<=row-1; i++) {
    free(final_arngd[i]); /* very much essential */
    final_arngd[i] = NULL;
  }
  free(final_arngd); /* very much essential */
  final_arngd = NULL;

  free(permuation_set);
  permuation_set = NULL;

  return (det);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void permut(int n, int **final_arngd) {
  int *v;
  int done; /*loop terminator*/

  /* The initial permutation is 1 2 3 ...*/
  /* P1 */
  int i;

  v = (int *)malloc((size_t)n * sizeof(int));
  if(v==NULL) {
    printf("dynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  for(i = 0; i < n; ++i) {
    *(v+i) = i + 1;
  }
  arranged(n,v,final_arngd);

  done = 1;
  do {
    done = next(v, n);
    if(!done) {
      arranged(n,v,final_arngd);  /* P3 */
    }
  }
  while(!done);

  free(v);
  v = NULL;
}
////////////////////////////////////////////////////////////////////////////////
/*!
  This just swaps the values of a and b

  i.e if a = 1 and b = 2, after

    swap(&a, &b);

  a = 2 and b = 1
  old was:
  #define SWAP(a, b) a = a + b - (b = a)
*/
void swap(int *x, int *y) {
  int tmp;
  tmp=*x;
  *x=*y;
  *y=tmp;
}

///////////
/*!
  Generates the next permutation of the vector v of length n.

  @return 1, if there are no more permutations to be generated

  @return 0, otherwise
*/
int next(int *v, int n) {
  /* P2 */
  /* Find the largest i */
  int i = n - 2; int k; int j;
  while((i >= 0) && (*(v+i) > *(v + i + 1))) {
    --i;
  }

  /* If i is smaller than 0, then there are no more permutations. */
  if(i < 0) {
    return 1;
  }

  /* Find the largest element after vi but not larger than vi */
  k = n - 1;
  while(*(v+i) > *(v+k)) {
    --k;
  }
  swap((v+i), (v+k));

  /* Swap the last n - i elements. */
  k = 0;
  for(j = i + 1; j < (n + i) / 2 + 1; ++j, ++k) {
    swap((v+j), (v + n - k - 1));
  }

  return 0;
}
//////
//------------------//
/*we store each time arrangement of 'v', as the row arangement in a 2D array called 'final_arngd'.
This array contains the permutation of the numbers, and will be accessed during printing the final permutations.*/
void arranged(int n, int *v, int **final_arngd) {
  int y;

  for(y=0; y<n; y++) {
    *(*(final_arngd+x)+y)=*(v+y); /* NOTE: logic. */
  }
  x++;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* A description program to calculate signature of a permutations by levi-civita symbol.
like, {1,2,3,4} has signature 1, (even permutations) and {1,3,2,4} has signature -1,
(odd permutations). This program's logic uses the formula of levi-civita symbol,
search wikipedia for more details.*/
int levi_civita(int *input_levi_civita, int n) {

  int i, k, product=1, sign=1;

  for(i=1; i<=n-1; i++) {
    for(k=i+1; k<=n; k++) {
      product=product*(input_levi_civita[k-1]-input_levi_civita[i-1]);
    }
    sign=sign*product/factorial(i);
    product=1;
  }
  return (sign);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int factorial(int num) {
  int fact_num;
  fact_num=num;

  if(num<0) {
    printf("Invalid Value.\n");
    return (0);
  }
  if((num==0)||(num==1)) {
    fact_num=1;
  }
  if(num>=2) {
    for(num; num>=2; num--) {
      fact_num=fact_num*(num-1);
    }
  }
  return (fact_num);
}

