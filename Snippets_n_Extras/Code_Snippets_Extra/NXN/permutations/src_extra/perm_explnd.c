#include <stdio.h>
#include <stdlib.h>
#define N 4
int stage=1;
////////////////////////////////////////////////////////////////////////////////
/*!
	This just swaps the values of a and b

	i.e if a = 1 and b = 2, after

		SWAP(a, b);

	a = 2 and b = 1
*/
#define SWAP(a, b) a = a + b - (b = a)
////////////////////////////////////////////////////////////////////////////////

void printv(int v[], int n);
int next(int v[], int n);

int main(int argc, char *argv[]) {
	int v[N];
	int n = N; int done; /*loop terminator*/

	/* The initial permutation is 1 2 3 ...*/
	/* P1 */
	int i;
	for (i = 0; i < n; ++i)
		v[i] = i + 1;
	printv(v, n);

	done = 1;
	do {
		if (!(done = next(v, n)))
			printv(v, n); /* P3 */
	} while (!done);
    system("PAUSE");
	return 0;
}

void printv(int v[], int n) {
	int i;
	printf("under printv()\n");
	for (i = 0; i < n; i++)
		printf("%d ", v[i]);
	printf("\n");
}

////////////////////////////////////////////////////////////////////////////////
/*!
	Generates the next permutation of the vector v of length n.

	@return 1, if there are no more permutations to be generated

	@return 0, otherwise
*/
int next(int v[], int n) {
	/* P2 */
	/* Find the largest i */
	int i = n - 2; int k; int j; int x;
	printf("under next(), %d-th print stage\n",stage);
	printf("--------------  i=n-2=%d\n",i);
	while ((i >= 0) && (v[i] > v[i + 1])){
		--i;
		printf("(i >= 0) && (v[i] > v[i + 1]) met, i=%d\n",i);
    }

	/* If i is smaller than 0, then there are no more permutations. */
	if (i < 0){
	    printf("(i < 0), so returning 1\n");
		return 1;
    }

	/* Find the largest element after vi but not larger than vi */
	k = n - 1;
	printf("--------------  k=%d\n",k);
	printf("--------------  v[i=%d]=%d, v[k=%d]=%d\n",i,v[i],k,v[k]);
	while (v[i] > v[k]){
		printf("---++++-------  v[i=%d] =%d, > v[k=%d] =%d\n",i,v[i],k,v[k]);
		printf("---++++------  swaped..\n");
		for (x = 0; x < n; x++)
            printf("%d ", v[x]);
        printf("\n");
		--k;
    }
    printf("--------------  k=%d\n",k);
	SWAP(v[i], v[k]);
	printf("--------------  swaped v[i=%d]=%d, v[k=%d]=%d\n",i,v[i],k,v[k]);

    printf("--------------  The current array is:\n");
	for (x = 0; x < n; x++)
		printf("%d ", v[x]);
	printf("\n");

	/* Swap the last n - i elements. */
	k = 0;
	for (j = i + 1; j < (n + i) / 2 + 1; ++j, ++k){
		printf("------++++++++  j=%d, (n+i)/2+1=%d, k=%d\n",j,(n+i)/2+1,k);
		printf("------++++++++  n-k-1=%d\n",n-k-1);
		SWAP(v[j], v[n - k - 1]);
		printf("------++++++++  swaped v[j=%d]=%d, v[n-k-1=%d]=%d\n",j,v[j],n-k-1,v[n-k-1]);
        printf("------++++++++ The current array is:\n");
        for (x = 0; x < n; x++)
            printf("%d ", v[x]);
        printf("\n");
    }
    printf("returning 0\n");
    system ("PAUSE");
    system ("cls");
    stage++;
	return 0;
}
////////////////////////////////////////////////////////////////////////////////

