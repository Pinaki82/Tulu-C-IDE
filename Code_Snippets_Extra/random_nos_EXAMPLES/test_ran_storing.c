#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "rand_gen.h"

int main(void) {
  int *sl_store, size, i, LOW, HIGH, rand_rtrn;
  /*declaring all the variables*/

  printf("input max size: ");
  scanf("%d",&size);
  printf("\n");
  /*here we set the maximum number to be stored in the array*/

  sl_store=(int *) malloc(size*sizeof(int));
  /*here we dynamically allocate memory required by the array*/

  if(sl_store == NULL) {
    printf("out of memory\n");
    exit(0);
  }
  /*here we check bounds*/

  time_t seconds;
  time(&seconds);
  srand((unsigned int) seconds);

  /*------------------------------------------*/
  /*----Rest of all the lines go to our code----*/
  LOW=0, HIGH=size;
  for(i=0; i<=size; i+=1) {
    rand_rtrn=rand_gen(&LOW,&HIGH);
    *(sl_store+i)=rand_rtrn;
  }
  for(i=0; i<=size; i+=1) {
    printf("%d. %d\n",i,*(sl_store+i));
  }
  free(sl_store);
  system("PAUSE");
  return 0;
}

