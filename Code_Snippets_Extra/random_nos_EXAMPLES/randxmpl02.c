#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define RAND_MAX 10 /* generates better random no */ /*gcc-Warning: RAND_MAX re-defined*/

int main(int argc, char *argv[]) {
  /* Simple "srand()" seed: just use "time()" */
  unsigned int iseed = (unsigned int)time(NULL);
  srand(iseed);

  /* Now generate 5 pseudo-random numbers */
  int i, j /* generates better random no */ ;
  for(i=0; i<5; i++) {
    printf("rand[%d]= %u\n", i, rand());
    j = 1 + (int)(10.0 * rand() / (RAND_MAX + 1.0));     /* generates better random no */
    printf("second case %d\n",j);  /* generates better random no */
  }
  system("PAUSE");
  return 0;
}

