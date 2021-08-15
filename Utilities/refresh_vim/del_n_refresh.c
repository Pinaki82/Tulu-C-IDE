// Last Change: 2013-09-25 08:33:53
/*
 * =====================================================================================
 *
 *       Filename:  del_n_refresh.c
 *
 *    Description:  delets _viminfo, _vim_mru_files, .vimbackup, .vimswap, .vimviews
 *
 *        Version:  1.0
 *        Created:  9/25/2013 8:31:34 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *   Organization: Iswarya Production
 *         Author: (Pinaki Sekhar Gupta)
 *
 * =====================================================================================
 */

#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define  N  6 /* number of stuffs to delete */

int main(void) {
  register int i, v;

  char del[5]="del ", star_qq[8]="\\*.*/q", removing_dir[37];
  /* chunk of words to pass to system(). 37 since 5+8+24 */

  for(i=0; i<37 ; i+=1) { /* filling with null terminator */
    removing_dir[i]='\0';
  }

  char removable_target[N][24]= { /* FIXME: warning: ISO C90 forbids mixed declarations and code [-pedantic] */
    "_viminfo",
    "_vim_mru_files",
    "yankring_history_v2.txt",
    ".vimbackup",
    ".vimswap",
    ".vimviews"
  };

  for(i=0; i<3 ; i+=1) { /* delets files */
    if(remove(*(removable_target+i)) != 0) {
      printf("Could not remove %s\n",*(removable_target+i));
    }
    else {
      printf("Removed %s\n",*(removable_target+i));
    }
  }


  for(i=3; i<6 ; i+=1) { /* delets files under the specified folders */
    for(v=0; v<37 ; v+=1) {
      removing_dir[v]='\0';
    }
    strcat(removing_dir,del);
    strcat(removing_dir,*(removable_target+i));
    strcat(removing_dir,star_qq);
    if(system(removing_dir) != 0) {
      printf("Could not remove %s\n",removing_dir);
    }
    else {
      printf("Removed %s\n",removing_dir);
    }
  }

  system("PAUSE");
  return EXIT_SUCCESS;
}

