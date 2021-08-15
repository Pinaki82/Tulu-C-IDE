// Last Change: 2014-01-24  Friday: 02:01:30 AM
/* chartestverifictn */
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if  !defined( __linux ) || !defined( __unix )
#  include <conio.h>
#endif

#if defined( __BORLANDC__ ) || defined( __TURBOC__ )
/* since Turbo C and old borland does not support new ANSI _getch() */
#  define  HOLD_TH_SCRN  getch()
#    else
#      define  HOLD_TH_SCRN  _getch()
#endif
#if ( defined( __linux ) || defined( __unix ) )
#  undef HOLD_TH_SCRN
#endif

int main(void) {
  int b;
  char a, consent;
  printf("Input a letter.\n");
  scanf("%c", & a);
  b=a;  /* char to int conversion */
  printf("number representation= %d\n", a);
  printf("letter representation= %c\n", b);
  if(b == a) { /* intensional incompatible comparison */
    printf("verified.\n\n");
  }


  fflush(stdin);
  printf("do again? (y/n)  ");
#if defined( __linux ) || defined( __unix )
  getchar();
  fflush(stdin);
#endif
  scanf("%c", &consent);
  printf("\n");
  if((consent=='n')||(consent=='N')) {
    exit(0);
  }
  else {
    main();
  }
#if !defined( __linux ) || !defined( __unix )
  HOLD_TH_SCRN;
# else
  getchar();
#endif
  return 0;
}

