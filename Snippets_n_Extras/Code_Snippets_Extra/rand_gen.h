#ifndef __RAND_GEN_H__
#define __RAND_GEN_H__

#ifdef __cplusplus
extern "C"
{
#endif

  int rand_gen(int *LOW, int *HIGH);    //use it as: a_variable=rand_gen(&lower_range, &upper_range);
  //you will get the returned value as your generated random number.

#ifdef __cplusplus
}
#endif

#endif // __RAND_GEN_H__

/*-------HELP-------------HELP-----------HELP------------*/
/*
HELP:
first #include <time.h> in the file where your main() is
(required for the function time, and for data type time_t),
then put the following three lines in your main(),
just after declaring all the variables either, or before calling the function rand_gen();
Also include rand_gen.h.
Do not write the three lines anywhere else except main()

time_t seconds;
time(&seconds);
srand((unsigned int) seconds);

 for(i=0;i<=size;i+=1){
  rand_rtrn=rand_gen(&LOW,&HIGH);
  *(sl_store+i)=rand_rtrn;
 }
 for(i=0;i<=size;i+=1){
  printf("%d. %d\n",i,*(sl_store+i));
 }

*/
/*-------------------------------------------------------*/


/*
Header: stdio.h
Reason: standard Input/Output
Header: stdlib.h
Reason: For functions rand and srand
*/
#include <stdio.h>
#include <stdlib.h>

int rand_gen(int *LOW, int *HIGH) {

  /*
  These constants define our upper
  and our lower bounds. The random numbers
  will always be between these values, inclusive.
  */
  int generated;

  generated = rand() % (*HIGH - *LOW + 1) + *LOW;
  /*
  Returns result.
  */
  return (generated);
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

