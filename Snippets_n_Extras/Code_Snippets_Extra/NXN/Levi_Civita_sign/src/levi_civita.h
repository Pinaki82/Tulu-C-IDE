#ifndef __LEVI_CIVITA_H__
#define __LEVI_CIVITA_H__

#include <stdio.h>
#include<stdlib.h>
#include "fact.h"
#define N 4

#ifdef __cplusplus
extern "C"
{
#endif

int levi_civita (int *input_levi_civita, int n); //use it as, signature=signature=levi_civita (permuation_set,N);

#ifdef __cplusplus
}
#endif

#endif
/* A description program to calculate signature of a permutations by levi-civita symbol.
like, {1,2,3,4} has signature 1, (even permutations) and {1,3,2,4} has signature -1,
(odd permutations). This program's logic uses the formula of levi-civita symbol,
search wikipedia for more details.*/

int levi_civita (int *input_levi_civita, int n){

 int i, k, product=1, sign=1;
 n=N;

 for (i=1;i<=n-1;i++){
  for (k=i+1;k<=n;k++){
   product=product*(input_levi_civita[k-1]-input_levi_civita[i-1]);
  }
  sign=sign*product/factorial(i);
  product=1;
 }
 return (sign);
}

