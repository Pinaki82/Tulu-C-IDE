#include<stdio.h>
#include<stdlib.h>
#include "levi_civita.h"
#define N 4
int main(void)
{
 int i;
 int permuation_set[N], signature;
 printf("Input the permutation ");
 for (i=0;i<=N-1;i++){
  scanf("%d",&permuation_set[i]);
 }
 printf("\n");
 signature=levi_civita (permuation_set,N);
 printf("signature %d\n",signature);
 system("PAUSE");
 return 0;
}

