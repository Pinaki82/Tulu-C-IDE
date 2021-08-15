// Last Change: 2013-07-05 14:13:02
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if  !((defined( __WIN32__ ) || defined( __WINDOWS__ )) \
    || (defined( __MINGW32__ ) || defined( __MINGW64__ ) || defined( __TINYC__ )))
#error  "OS or Compiler not supported"
#endif

#define  N  2

void SFN_cnvtr(void);

int main(void) {
  char consent;

  SFN_cnvtr();
  consent='y';
  while(!(consent=='n' || consent=='N')) {
    fflush(stdin);
    printf("Do Again(y/n): ");
    scanf("%c",&consent);
    printf("\n");
    if(!(consent=='n' || consent=='N')) {
      SFN_cnvtr();
    }
  }

  return EXIT_SUCCESS;
}

void SFN_cnvtr(void) {
  int i;
  char store_evrthng[9020];
  char two_sides[N][20]= {
    "cmd /c for %A in (\"",
    "\") do @echo %~sA",
  };
  char fullpath[9000];
  fflush(stdin);
  printf("Write/paste the full path:\n");
  gets(fullpath);
  strcat(store_evrthng,*(two_sides+0));
  strcat(store_evrthng,fullpath);
  strcat(store_evrthng,*(two_sides+1));
  /*
  printf("Total is: %s\n",store_evrthng);
  */
  printf("\nEquivalent SFN is:\n");
  printf("----------------------------\n");
  system(store_evrthng);
  printf("----------------------------\n");
  printf("\n");
  for(i=0; i<=9020-1 ; i++) {
    store_evrthng[i]='\0';
  }

  fflush(stdin);
}


