// Last Change: 2016-01-20  Wednesday: 01:20:46 PM
/*
   An example program of dynamic memory allocation for a 2D array
   solely using pointers.
   Method 3: We'll have to simulate the 2D array (of pointers) with another pointer,
   and this will be a pointer to a pointer.
   The idea is to first create a one dimensional array of pointers (row basis),
   and then,
   for each array entry (each row's base address/pointers),
   create another one dimensional array of pointers (column basis).

   We can create an array of pointers also dynamically using a double pointer.
   Once we have an array pointers allocated dynamically, we can dynamically
   allocate memory and for every row.
   Note that *(arr+i) is arr[i] here.
 * * * * * * * * * * * * * * The HEART of this method is: * * * * * * * * * * *
   that the arr[i][j] is same as          *(*(arr+i)+j) and also,
   its vice-versa e.g.,                   *(*(arr+i)+j) is same as arr[i][j]
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/
/*

*/
#include <errno.h> /* required */
#include <math.h>
#include <stdio.h> /* required */
#include <stdlib.h> /* required */
#include <string.h>

int main(void) {
  int arr[3][4][2]= {
    {
      {2, 4},
      {7, 8},
      {3, 4},
      {5, 6},
    },
    {
      {7, 6},
      {3, 4},
      {5, 3},
      {2, 3},
    },
    {
      {8, 9},
      {7, 2},
      {3, 4},
      {5, 1}
    }
  };
int xlen, ylen, zlen, i=0, j=0, k=0; /*  **arr is a 2D array, essentially a
                                    collection of some array (of pointers).*/

  xlen=3, ylen=4, zlen=2;

  printf("\nyour input was:\n");
  for(i=0; i<=xlen-1 ; i++) {
    for(j=0; j<=ylen-1 ; j++) {
      for(k=0; k<=zlen-1 ; k++) {
        printf("%d.%d.%d. arr=%d\n",i,j,k,*(*(*(arr+i)+j)+k)); /* NOTE: Note that arr[i][j] is same as *(*(arr+i)+j) */
      }
    }
  }
  printf("\n------------by arr[i][j][k]----------------\n");
  for(i=0; i<=xlen-1 ; i++) {
    for(j=0; j<=ylen-1 ; j++) {
      for(k=0; k<=zlen-1 ; k++) {
        printf("%d.%d.%d. arr=%d\n",i,j,k,arr[i][j][k]); /* NOTE: Note that arr[i][j] is same as *(*(arr+i)+j) */
      }
    }
  }
  system("PAUSE");
  return EXIT_SUCCESS;
}


