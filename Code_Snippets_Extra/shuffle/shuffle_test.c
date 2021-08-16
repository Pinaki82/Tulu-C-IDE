#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "shuffle.h"
#include "resource.h"

FILE *f1;

int main(void) {
  int *sl_store, min_size, max_size, size, i;
  system("COLOR 0A");
  /*declaring all the variables*/
  f1 = fopen("output.txt", "wt");    /* open a file for output */

  printf("input min size: ");
  scanf("%d", &min_size);
  printf("\n");
  printf("input max size: ");
  scanf("%d", &max_size);
  printf("\n");
  /*here we set the maximum number to be stored in the array*/

  size = max_size - min_size + 1;

  sl_store = (int *) malloc(size * sizeof(int));
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

  shuffled_array(sl_store, &min_size, &max_size);
  for(i = 0 ; i <= size - 1; i += 1) {
    printf("%d. %d\n", min_size + i, * (sl_store + i));
    fprintf(f1, "%d. %d\n", min_size + i, * (sl_store + i));
  }

  free(sl_store);
  fclose(f1);
  system("PAUSE");
  return 0;
}

