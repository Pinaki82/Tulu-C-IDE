/*
http://www.cprogramming.com/tutorial/random.html
Steven Billington
January 17, 2003
randxmpl05.c originaly was exDice.cpp
Program rolls two dice with random
results.
*/
/*
Header: stdio.h
Reason: standard Input/Output
Header: stdlib.h
Reason: For functions rand and srand
Header: time.h
Reason: For function time, and for data type time_t
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
/*
These constants define our upper
and our lower bounds. The random numbers
will always be between 1 and 6, inclusive.
*/
const int LOW = 1;
const int HIGH = 6;


int main(void) {
  /*
  Variables to hold random values
  for the first and the second die on
  each roll.
  */
  int first_die, sec_die;
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
  Get first and second random numbers.
  */
  first_die = rand() % (HIGH - LOW + 1) + LOW;
  sec_die = rand() % (HIGH - LOW + 1) + LOW;
  /*
  Output first roll results.
  */
  printf("Your roll is..  first_die=%d, sec_die=%d\n",first_die,sec_die);
  /*
  Get two new random values.
  */
  first_die = rand() % (HIGH - LOW + 1) + LOW;
  sec_die = rand() % (HIGH - LOW + 1) + LOW;
  /*
  Output second roll results.
  */
  printf("My roll is..    first_die=%d, sec_die=%d\n",first_die,sec_die);
  system("PAUSE");
  return 0;
}
/*
 * LOGIC:
 * For any two integers, say a and b, a % b is between 0 and b - 1,
 * inclusive. With this in mind, the expression rand() % high + 1 would generate
 * a number between 1 and high, inclusive, where high is less than or equal to RAND_MAX,
 * a constant defined by the compiler.
 * To place a lower bound in replacement of 1 on that result, we can have the
 * program generate a random number between 0 and (high - low + 1) + low.
*/

