// Last Change: 2023-02-21  Tuesday: 08:21:27 PM
#ifndef __NODERAND_H__
#define __NODERAND_H__

#ifdef __cplusplus
extern "C" {
#endif

#define RAND_MAX 10 /* generates better random no */ /*gcc-Warning: RAND_MAX re-defined*/
unsigned int rand_10(); // generates 8/9/10 digit randon numbers
int rand_range(int *size, int *low); //use it as: a_variable=rand_range(&upper_range, &lower_range);
//you will get the returned value as your generated random number.

#ifdef __cplusplus
}
#endif

#endif // __NODERAND_H__

/*
  Header: stdio.h
  Reason: standard Input/Output
  Header: stdlib.h
  Reason: For functions rand and srand
  Header: time.h
  Reason: Required for the function time, and for data type time_t
*/
#include <Arduino.h>
#include "HardwareSerial.h"
#include <stdlib.h>
#include <time.h>

unsigned int rand_10() {
  /*
    Declare a variable to hold seconds in the clock.
  */
  time_t seconds;
  /*
    Get the value from the system clock and store
    it in the seconds variable.
  */
  time(&seconds);
  /*
    Convert seconds to an unsigned
    integer.
  */
  srand((unsigned int) seconds);
  /* Simple "srand()" seed: just use "time()" */
  unsigned int iseed = (unsigned int)time(NULL);
  //srand(iseed);
  srand((iseed + (unsigned int)(1 + (int)(10.0 * rand() / (RAND_MAX + 1.0)))) / 2);  /* generates better random no */
  /* Now generate 5 pseudo-random numbers and print the last one */
  int i = 0, j = 0;

  for(i = 0; i < 5; i++) {
    rand();
    rand();
    rand();
    j = 1 + (int)(10.0 * rand() / (RAND_MAX + 1.0));  /* generates better random no */
  }

  return j;
}

int rand_range(int *size, int *low) {
  int high = *size;
  /* size, here we set the maximum value of the generated random number, i.g, 25 etc. */
  /*
    These constants define our upper
    and our lower bounds. The random numbers
    will always be between these values, inclusive.
  */
  time_t seconds;
  time(&seconds);
  srand((unsigned int) seconds);
  unsigned int iseed = (unsigned int)time(NULL);
  //srand(iseed);
  srand((iseed + (unsigned int)(1 + (int)(10.0 * rand() / (RAND_MAX + 1.0)))) / 2);  /* generates better random no */
  int generated;

  for(int i = 0; i < 5; i++) {
    generated = rand() % (high - *low + 1) + *low;
  }

  /*
    Returns result.
  */
  return (generated);
  /*
    LOGIC:
    For any two integers, say a and b, a % b is between 0 and b - 1,
    inclusive. With this in mind, the expression rand() % high + 1 would generate
    a number between 1 and high, inclusive, where high is less than or equal to RAND_MAX,
    a constant defined by the compiler.
    To place a lower bound in replacement of 1 on that result, we allow the
    program to generate a random number between 0 and (high - low + 1) + low.
  */
}

