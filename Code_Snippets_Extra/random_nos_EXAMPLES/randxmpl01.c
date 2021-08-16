#include <stdio.h>
#include <stdlib.h>
/*
** Program RANDOM1.C
**
** Generates three random numbers in range of 0 to 99 and
** reports as to which is the largest and which is the smallest.
**
** Intended to show the use of functions randomize(), random() anf the
** use of functions.
**
** Peter H. Anderson, MSU, Feb 6, '97
*/

#include <stdio.h>
#include <stdlib.h> /* required for randomize() and random() */
#include <conio.h>
#if !(defined(__TURBOC__) || defined(__DMC__))
#error "ancient procedure used, new compiler not supported, use TURBOC or Digital Mars"
#endif

int gen_rand(void);   /* note these are declarations of functions */
int find_max(int x, int y, int z);
int find_min(int x, int y, int z);

FILE *f1;

int main(void) {
  int num1, num2, num3, max, min;

  system("CLS");  /* clear the screen */

  f1=fopen("output.txt", "wt"); /* open a file for output */

  randomize();  /* uncomment this if you want a random start */

  num1=gen_rand();
  num2=gen_rand();
  num3=gen_rand();

  max=find_max(num1, num2, num3);
  min=find_min(num1, num2, num3);

  printf("Random numbers are %d, %d, and %d\n", num1, num2, num3);
  fprintf(f1, "Random numbers are %d, %d, and %d\n", num1, num2, num3);

  printf("Largest is %d.  Smallest is %d.\n", max, min);
  fprintf(f1, "Largest is %d.  Smallest is %d.\n", max, min);

  fclose(f1);
  system("PAUSE");
  return 0;
}

int gen_rand(void)
/* returns random number in range of 0 to 99 */
{
  int n;
  n=random(100);  /* n is random number in range of 0 - 99 */
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
    min = y;
  }
  return(min);
}

