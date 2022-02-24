// Last Change: 2022-02-23  Wednesday: 08:46:01 PM
/* Opens Locations, defined in environment variables, e.g.,
   My Documents, Programs Files etc. */
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if  !((defined( __WIN32__ ) || defined( __WINDOWS__ )) \
    || (defined( __MINGW32__ ) || defined( __MINGW64__ ) || defined( __TINYC__ )))
#error  "OS or Compiler not supported"
#endif

#define  N  17 /* number of locations */

int main(void) {
  int i, choice;
  char consent;
  char explore_location[N][100] = { /* not more than 100 characters */
    "explorer %USERPROFILE%\\Documents",
    "explorer %USERPROFILE%\\Downloads",
    "explorer %APPDATA%",
    "explorer %LOCALAPPDATA%",
    "explorer %USERPROFILE%",
    "explorer %SYSTEMDRIVE%",
    "explorer %HOMEDRIVE%",
    "explorer %SYSTEMROOT%",
    "explorer %WINDIR%",
    "explorer %HOMEPATH%",
    "explorer %TMP%",
    "explorer %PROGRAMDATA%",
    "explorer %PROGRAMDATA%\\Microsoft\\Windows\\Start\ Menu\\Programs",
    "explorer %ProgramFiles%",
    "explorer %ProgramFiles(x86)%",
    "explorer %CommonProgramFiles%",
    "explorer %CommonProgramFiles(x86)%",
  }; /* character array containing the location */
  printf("Which location to explore?\n");

  for(i = 0; i <= N - 1 ; i += 1) {
    printf("%d. %s\n", i + 1, *(explore_location + i)); /* i+1 to show items from 1 */
  }

  scanf("%d", &choice);
  choice = choice - 1;  /* reducing choice
                           since the user will input one more */

  if((choice < 0) || (choice > N - 1)) { /* since choice has already been reduced */
    printf("\ninvalid input, exiting..\n");
    system("PAUSE");
    exit(1);
  }

  printf("Exploring %d. %s\n", choice + 1, *(explore_location + choice));
  /* increasing choice for user's reference */
  system(*(explore_location + choice));
  //
  printf("Do again? (y/n)  ");
  fflush(stdin);
  scanf("%c", &consent);
  printf("\n");

  if((consent == 'n') || (consent == 'N')) {
    exit(0);
  }

  else {
    main();
  }

  return EXIT_SUCCESS;
}

