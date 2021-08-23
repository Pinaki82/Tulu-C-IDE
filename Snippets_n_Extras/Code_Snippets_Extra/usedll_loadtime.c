#include<stdio.h>
#include<stdlib.h>
#include "easy_dll.h"
int main(void){
 int a;
 a=func_multi01_dll ();
 printf("returned value %d\n",a);
 system("PAUSE");
 return 0;
}

