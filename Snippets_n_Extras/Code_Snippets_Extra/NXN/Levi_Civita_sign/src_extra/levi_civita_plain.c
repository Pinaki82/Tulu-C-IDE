/* A description program to calculate signature of a permutations by levi_civita symbol.
like, {1,2,3,4} has signature 1, (even permutations) and {1,3,2,4} has signature -1,
(odd permutations). This program's logic uses the formula of levi-civita symbol,
search wikipedia for more details.*/
#include<stdio.h>
#include<stdlib.h>
#include "fact.h"
#define N 4
int main(void)
{
 int i, k, product=1, sign=1;
 int input_levi_civita[N];
 printf("input the 4 elements ");
 for (i=0;i<=N-1;i++){
  scanf("%d",&input_levi_civita[i]);
 }
 printf("\n");
 for (i=0;i<=N-1;i++){
  printf("%d ",input_levi_civita[i]);
 }
 printf("\n");
/*=============================================*/
 for (i=1;i<=N-1;i++){
  for (k=i+1;k<=N;k++){
   product=product*(input_levi_civita[k-1]-input_levi_civita[i-1]);
   //printf("product=%d\n",product);
  }
  //printf("factorial %d=%d\n",i,factorial(i));
  sign=sign*product/factorial(i);
  //printf("b. sign=%d\n",sign);
  product=1;
 }
 printf("sign %d\n",sign);
 system("PAUSE");
 return 0;
}

