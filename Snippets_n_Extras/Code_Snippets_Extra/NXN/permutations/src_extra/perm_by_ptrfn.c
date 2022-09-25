#include <stdio.h>
#include<stdlib.h>
#define NROW 24 /*row. dimension of the permutation array. usually, factorial(col) */
#define NCOL 4 /*col. dimension of the permutation array*/
////////////////////////////////////////////////////////////////////////////////
/*!
	This just swaps the values of a and b

	i.e if a = 1 and b = 2, after

		SWAP(a, b);

	a = 2 and b = 1
*/
#define SWAP(a, b) a = a + b - (b = a)
////////////////////////////////////////////////////////////////////////////////

void permut(int n, int *final_arngd);
int next(int *v, int n);
int fact(int num);
void arranged (int n, int *v, int *final_arngd);

int x=0;

int main(void){
 int i, j, n=NCOL; int final_arngd[NROW][NCOL];
 permut(n,*final_arngd);
 	for (i=0;i<24;i++){
	 for (j=0;j<n;j++){
	  printf("%d ",*(*final_arngd+i*n+j));
	 }
	 printf("\n");
	}
	printf("\n");
    system("PAUSE");
	return 0;
}


void permut(int n, int *final_arngd) {
	int v[NCOL];
	int done; /*loop terminator*/

	/* The initial permutation is 1 2 3 ...*/
	/* P1 */
	int i; n = NCOL;
	for (i = 0; i < n; ++i)
		*(v+i) = i + 1;
	arranged (n,v,final_arngd);

	done = 1;
	do {
		if (!(done = next(v, n))){
			arranged (n,v,final_arngd); /* P3 */
			}
	} while (!done);
}

////////////////////////////////////////////////////////////////////////////////
/*!
	Generates the next permutation of the vector v of length n.

	@return 1, if there are no more permutations to be generated

	@return 0, otherwise
*/
int next(int *v, int n) {
	/* P2 */
	/* Find the largest i */
	int i = n - 2; int k; int j;
	while ((i >= 0) && ( *(v+i) > *(v + i + 1)))
		--i;

	/* If i is smaller than 0, then there are no more permutations. */
	if (i < 0)
		return 1;

	/* Find the largest element after vi but not larger than vi */
	k = n - 1;
	while (*(v+i) > *(v+k))
		--k;
	SWAP(*(v+i), *(v+k));

	/* Swap the last n - i elements. */
	k = 0;
	for (j = i + 1; j < (n + i) / 2 + 1; ++j, ++k)
		SWAP(*(v+j), *(v + n - k - 1));

	return 0;
}
////////////////////////////////////////////////////////////////////////////////

//-------------------//factorial calulations
int fact(int num)
{
	int fact_num;
	fact_num=num;
	if (num<0)
	{
		 printf("Invalid Value.\n");
		 system("PAUSE");
		 system ("exit");
    }
	if ((num==0)||(num==1))
    fact_num=1;
	if (num>=2)
	{
		for (num;num>=2;num--)
		{
			fact_num=fact_num*(num-1);
		}
	}
	return (fact_num);
}
//-------------------

//------------------//
/*we store each time arrangement of 'v', as the row arangement in a 2D array called 'final_arngd'.
This array contains the permutation of the numbers, and will be accessed during printing the final permutations.*/
void arranged (int n, int *v, int *final_arngd){
 int y;

  for (y=0;y<n;y++){
  *(final_arngd+x*NCOL+y)=*(v+y);
  }
  x++;
}

