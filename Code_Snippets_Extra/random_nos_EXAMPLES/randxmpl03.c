#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
  /* Simple "srand()" seed: just use "time()" */
  unsigned int iseed = (unsigned int)time(NULL);
  srand(iseed);

  /* Now generate 5 pseudo-random numbers */
  int i;
  for(i=0; i<5; i++) {
    printf("rand[%d]= %u\n", i, rand());
  }
  system("PAUSE");
  return 0;
}

