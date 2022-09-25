/*Fil 2D with 1D*/
#include<stdio.h>
#include<stdlib.h>
int main(void){
 int arr2d[4][4]={
			    {1,2,3,4},
				{5,6,7,8},
				{9,10,11,12},
				{13,14,15,16}
			   };
 int arr1d[4]={4,5,8,7};
 int i, j, x;
 for (x=0,i=0;i<4;i++,x++){
  for (j=0;j<4;j++){
   //arr2d[i][j] = arr1d[j]+x ; //or,
   *(*arr2d+i*4+j) = *(arr1d+j)+x ;
  }
 }
 for (i=0;i<4;i++){
  for (j=0;j<4;j++){
   printf("%d ",arr2d[i][j]);
  }
  printf("\n");
 }
 printf("\n");
 system("PAUSE");
 return 0;
}

