// Last Change: 2013-06-26 11:49:03
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printv(int v[], int n);
void swap(int *x, int *y);
int next(int v[], int n);

int main(void) {
  int *v; /* This is the array */
  int i, size_of_arr; /*loop terminator*/
  printf("Know the next permutation.\nhow long your array is (no. of elements):\n");
  scanf("%d",&size_of_arr);

  v = (int *)malloc((size_t)size_of_arr * sizeof(int));
  if(v==NULL) {
    fprintf(stderr, "\ndynamic memory allocation failed\n");
    exit(EXIT_FAILURE);
  }

  printf("input the elements with spaces:\n");
  for(i=0; i<=size_of_arr-1 ; i+=1) {
    scanf("%d",(v+i));
  }
  printf("\n");
  /* P1 */

  next(v,size_of_arr);
  printf("returned to main(). Next permutation is:\n");
  printv(v, size_of_arr);

  free(v);
  v = NULL;
  system("PAUSE");
  return 0;
}

void printv(int *v, int n) {
  /* just to show off the last filled array, from main */
  int i;
  for(i = 0; i < n; i++) {
    printf("%d ", *(v+i));
  }
  printf("\n");
}

void swap(int *x, int *y) {
  int tmp;
  tmp=*x;
  *x=*y;
  *y=tmp;
}

////////////////////////////////////////////////////////////////////////////////
/*!
  Generates the next permutation of the vector v of length n.

  @return 1, if there are no more permutations to be generated

  @return 0, otherwise
*/
int next(int *v, int n) {
  /* P2 */
  /* Find the largest i */
  int i = n - 2; int k; int j, x;

  printf("--------------\n");
  printf("               n=%d, i=n-2=%d\n",n,i);
  printf("               here, v[%d]=%d, v[%d+1]=%d\n",i,v[i],i,v[i+1]);
  printf("stage A\n");                                      /* NOTE: stage A */

  if(!((i >= 0) && (*(v+i) > *(v+i+1)))) {
    printf("(%d>=0) && (v[%d]>v[%d+1]) not met, i=%d\n",i,i,i,i);
  }
  while((i >= 0) && (*(v+i) > *(v+i+1))) {
    printf("(%d>=0) && (v[%d]>v[%d+1]) met, decrementing i\n",i,i,i); /*new*/
    --i;
    printf("i decremented, i=%d\n",i); /*new*/
    /*printf("(%d>=0) && (v[%d]>v[%d+1]) met, decrementing i, i=%d\n",i,i,i,i);*/
  }

  /* If i is smaller than 0, then there are no more permutations. */
  printf("stage B\n");                                      /* NOTE: stage B */
  if(i < 0) {
    printf("i=%d, (i < 0), so returning 1 (finished)\n",i);
    return 1;
  }

  /* Find the largest element after vi but not larger than vi */
  printf("stage C\n");                                      /* NOTE: stage C */
  k = n - 1;
  printf("               k=n-1=%d\n",k);
  printf("checking v[i]>v[k] or not.\n");
  printf("--------------  v[%d]=%d, v[%d]=%d\n",i,v[i],k,v[k]);
  while(*(v+i) > *(v+k)) {
    printf("---++++-------  v[%d]=%d > v[%d]=%d\n",i,v[i],k,v[k]);
    printf("decrementing k, ");
    --k;
    printf("k=%d\n",k);
  }
  printf("\n--------------  k=%d\n",k);
  printf("stage D\n");                                      /* NOTE: stage D */
  printf("n=%d, i=%d, k=%d\n",n,i,k);
  printf("---Always swapped --- before swap, v[i=%d]=%d, v[k=%d]=%d\n",i,v[i],k,v[k]);
  swap((v+i), (v+k));
  printf("--------------------- swaped v[i=%d]=%d, v[k=%d]=%d\n",i,v[i],k,v[k]);
  printf("------++++++++ The current array is:\n");
  for(x = 0; x < n; x++) {
    printf("%d ", v[x]);
  }
  printf("\n");

  /* Swap the last n - i elements. */
  printf("assigning: k=0\n");
  k = 0;

  for(j = i + 1; j < (n + i) / 2 + 1; ++j, ++k) {
    printf("checking j < (n+i)/2+1 or not.\n");
    printf("n=%d, i=%d, j=%d, k=%d\n",n,i,j,k);
    printf("------+++++++++++  j=%d, (n+i)/2+1=%d, k=%d\n",j,(n+i)/2+1,k);
    printf("------+++++++++++  n-k-1=%d\n",n-k-1);
    printf("-----+++++++++ preparing swap v[j] and v[n-k-1]\n");
    printf("-----+++++++++ before swap v[%d]=%d, v[%d]=%d\n",j,v[j],n-k-1,v[n-k-1]);
    swap((v+j), (v+(n-k-1)));
    printf("-----+++++++++ swaped v[%d]=%d, v[%d]=%d\n",j,v[j],n-k-1,v[n-k-1]);
    printf("------++++++++ The current array is:\n");
    for(x = 0; x < n; x++) {
      printf("%d ", v[x]);
    }
    printf("\nincrementing j and k");
    printf("\n");
  }
  printf("       returning 0\n............\n");
  return 0;
}
////////////////////////////////////////////////////////////////////////////////

