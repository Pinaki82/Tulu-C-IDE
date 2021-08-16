/* ---------- HELP-----------HELP-----------HELP------------
 * * * use this header as mentioned below * * *
 Dependency: rand_gen.h

size = max_size - min_size + 1;
sl_store = ( int *)malloc((size_t)size * sizeof(int));
time_t seconds;
time ( &seconds );
srand ( ( unsigned int ) seconds );
shuffled_array ( sl_store, &min_size, &max_size );
  for ( i = 0 ; i <= size - 1; i += 1 ) {
    printf("%d. %d\n", min_size + i, * (sl_store + i));
    fprintf(f1, "%d. %d\n", min_size + i, * (sl_store + i));
    ..................
  }
*/

#ifndef __SHUFFLE_H__
#define __SHUFFLE_H__

#ifdef __cplusplus
extern "C"
{
#endif

  void shuffled_array(int *store_4_shuffle, int *LOW, int *HIGH);    //see HELP above

#ifdef __cplusplus
}
#endif

#endif // __SHUFFLE_H__

#include <stdio.h>
#include <stdlib.h>
#include "rand_gen.h"
#define YES 1
#define NO 0

void shuffled_array(int *store_4_shuffle, int *LOW, int *HIGH) {
  int size, i, k, j, temp01, zero_appeared = 0, zero_stored = 0, rejected_4_storing;
  if(store_4_shuffle == NULL) {
    printf("out of memory\n");
    exit(0);
  }
  size = *HIGH - *LOW + 1;
  if(*LOW != 0) {
    zero_appeared = 1; /* stop zero-related calculations
                          here if zero is not required */
  }
  for(i = 0; i <= size - 1; i += 1) {
    /* fill the entire array with an arbitrary
     num. that will not be in use.
     so that repeated numbers (such as 0)
     doesn't create infinite loops,
     (specifically in the 2-nd for loop) */
    * (store_4_shuffle + i) = *HIGH + 1;
  }
  //---------------------------------
  for(i = 0 ; i <= size - 1 ; i += 1) {
    temp01 = rand_gen(LOW, HIGH);
    if((*LOW == 0) && (temp01 == 0) && (zero_appeared > 0)) {
      zero_appeared += 1;
    }
    for(k = 0 ; k <= size - 1; k += 1) {
      if(* (store_4_shuffle + k) == 0) {
        zero_stored += 1;
        break;
      }
    }
    if((zero_appeared > 0) && (zero_stored > 0)) {
      while(temp01 == 0) {
        temp01 = rand_gen(LOW, HIGH);
      }
    }
    rejected_4_storing = NO;
    for(j = 0 ; j <= size - 1 ; j += 1) {
      if(* (store_4_shuffle + j) == temp01) {
        rejected_4_storing = YES;
        i -= 1; /* this part is v.v. important,
                   since 1st for-loop could not store anything
                   into the array due to rejection, it needs repetition */
        break;
      }
    }
    if(rejected_4_storing == YES) {
      continue;
    }
    else if(rejected_4_storing == NO) {
      * (store_4_shuffle + i) = temp01;
    }
  }
  //---------------------------------
}

