// Last Change: 2020-11-16  Monday: 10:07:14 PM
#include <stdio.h>

int main(){
  int **someinteger_not_initialised; // pointer to pointer to an int
  int k;
  **someinteger_not_initialised=&k; // invalid assignment
  return 0;
}
