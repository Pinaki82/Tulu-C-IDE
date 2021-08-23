#include<stdio.h>
#include<stdlib.h>
int i;

int main(void)
{
 srand( time(NULL) );
   for( i = 0; i < 10; i++ )
     printf( "Random number :%d: %d\n", i, rand() );
 system("PAUSE");
 system("exit");
}
