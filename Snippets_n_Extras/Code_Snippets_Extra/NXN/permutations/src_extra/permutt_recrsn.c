#include <stdio.h>
#define N 5

void permute(char list[],int k, int m);

int main (int argc, char *argv[])
{
 char list[5]={'a','b','c','d','e'};
 permute(list,0,N);
 getchar();
 return(0);
}


void permute(char list[],int k, int m){
 int i;
 char temp;

 if(k==m){
  /* PRINT A FROM k to m! */
  for(i=0;i < N;i++){
   printf("%c",list[i]);
  }
  printf("\n");
 }
 else {
       for(i=k;i < m;i++){
         /* swap(a[i],a[m-1]); */
        temp=list[i];
        list[i]=list[m-1];
        list[m-1]=temp;

        permute(list,k,m-1);

         /* swap(a[m-1],a[i]); */

        temp=list[m-1];
        list[m-1]=list[i];
        list[i]=temp;
       }
 }
}

