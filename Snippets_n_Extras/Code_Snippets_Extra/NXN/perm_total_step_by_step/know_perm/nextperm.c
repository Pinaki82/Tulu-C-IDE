// Last Change: 2013-06-25 22:22:55
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
  /*just to show off the last filled array, from main*/
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
  int i = n - 2; int k; int j;

  /*[> NOTE: stage A <]*/
  while((i >= 0) && (*(v+i) > *(v+i+1))) {
    --i;
  }

  /* If i is smaller than 0, then there are no more permutations. */
  /*[> NOTE: stage B <]*/
  if(i < 0) {
    return 1;
  }

  /* Find the largest element after vi but not larger than vi */
  /*[> NOTE: stage C <]*/
  k = n - 1;
  while(*(v+i) > *(v+k)) {
    --k;
  }
  /*[> NOTE: stage D <]*/
  swap((v+i), (v+k));

  /* Swap the last n - i elements. */
  k = 0;

  for(j = i + 1; j < (n + i) / 2 + 1; ++j, ++k) {
    swap((v+j), (v+(n-k-1)));

  }
  return 0;
}
////////////////////////////////////////////////////////////////////////////////

