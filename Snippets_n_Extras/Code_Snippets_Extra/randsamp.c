#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int gen_rand(void);   /* note these are declarations of functions prototype*/
int find_max(int x, int y, int z);
int find_min(int x, int y, int z);

FILE *f1;

int main(void) {
  int num1, num2, num3, max, min, i;
  system("cls");;  /* clear the screen */

  srand(time(NULL));
  for(i = 0; i < 10; i++) {
    printf("Random number %d: %d\n", i, rand());
  }


  num1=gen_rand();
  num2=gen_rand();
  num3=gen_rand();

  max=find_max(num1, num2, num3);
  min=find_min(num1, num2, num3);

  printf("Random numbers are %d, %d, and %d\n", num1, num2, num3);
  fprintf(f1, "Random numbers are %d, %d, and %d\n", num1, num2, num3);

  printf("Largest is %d.  Smallest is %d.\n", max, min);

  fclose(f1);
  system("PAUSE");
  return 0;
}

int gen_rand(void) {
  int n;
  n=rand();  /* n is random number */
  printf("returning frm gen_rand.. %d\n",n);
  return(n);
}

int find_max(int x, int y, int z)
/* returns largest number */
{
  int max;
  if((x>=y) && (x>=z)) {
    max = x;
  }
  else if((y>=x) && (y>=z)) {
    max = y;
  }
  else {
    max = z;
  }
  return(max);
}

int find_min(int x, int y, int z)
/* returns smallest number */
{
  int min;
  if((x<=y) && (x<=z)) {
    min = x;
  }
  else if((y<=x) && (y<=z)) {
    min = y;
  }
  else {
    min = z;
  }
  return(min);
}

