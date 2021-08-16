/*Steven Billington
January 17, 2003
Ranexample.cpp
Program displays three random integers.
*/
/*
Header: stdio.h
Reason: standard Input/Outpu
Header: stdlib
Reason: For functions rand and srand
Header: time.h
Reason: For function time, and for data type time_t
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main(void) {
  /*
  Declare variable to hold seconds on clock.
  */
  time_t seconds;
  /*
  Get value from system clock and
  place in seconds variable.
  */
  time(&seconds);
  /*
  Convert seconds to a unsigned
  integer.
  */
  srand((unsigned int) seconds);
  /*
  Output random values.
  */
  printf("%u\n",rand());
  printf("%u\n",rand());
  printf("%u\n",rand());
  system("PAUSE");
  return 0;
}

