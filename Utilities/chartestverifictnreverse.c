// Last Change: 2014-01-24  Friday: 04:14:38 AM
/* chartestverifictnreverse */
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>

#if defined( __BORLANDC__ ) || defined( __TURBOC__ )
/* since Turbo C and old borland does not support new ANSI _getch() */
#define  HOLD_TH_SCRN  getch()
#else
#define  HOLD_TH_SCRN  _getch()
#endif

int main(void) {
  int b;
  char a, consent;
  printf("Input a number.\n");
  scanf("%d", &b);
  a=b; /* int to char conversion */
  printf("letter representation= %c\n", a);
  printf("number representation= %d\n", b);
  if(a == b) { /* intensional incompatible comparison */
    printf("verified.\n\n");
  }

  printf("do again? (y/n)  ");
  fflush(stdin);
  scanf("%c", &consent);
  printf("\n");
  if((consent=='n')||(consent=='N')) {
    exit(0);
  }
  else {
    main();
  }

  HOLD_TH_SCRN;
  return 0;
}


