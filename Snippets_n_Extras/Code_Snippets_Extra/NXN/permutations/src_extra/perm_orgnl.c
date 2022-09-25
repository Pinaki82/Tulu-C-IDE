#include <stdio.h>

void printv(int v[], int n) {
	int i;

	for (i = 0; i < n; i++)
		printf("%d ", v[i]);
	printf("\n");
}

/*!
	This just swaps the values of a and b

	i.e if a = 1 and b = 2, after

		SWAP(a, b);

	a = 2 and b = 1
*/
#define SWAP(a, b) a = a + b - (b = a)

/*!
	Generates the next permutation of the vector v of length n.

	@return 1, if there are no more permutations to be generated

	@return 0, otherwise
*/
int next(int v[], int n) {
	/* P2 */
	/* Find the largest i */
	int i = n - 2;
	while ((i >= 0) && (v[i] > v[i + 1]))
		--i;

	/* If i is smaller than 0, then there are no more permutations. */
	if (i < 0)
		return 1;

	/* Find the largest element after vi but not larger than vi */
	int k = n - 1;
	while (v[i] > v[k])
		--k;
	SWAP(v[i], v[k]);

	/* Swap the last n - i elements. */
	int j;
	k = 0;
	for (j = i + 1; j < (n + i) / 2 + 1; ++j, ++k)
		SWAP(v[j], v[n - k - 1]);

	return 0;
}

int main(int argc, char *argv[]) {
	int v[128];
	int n = 3;

	/* The initial permutation is 1 2 3 ...*/
	/* P1 */
	int i;
	for (i = 0; i < n; ++i)
		v[i] = i + 1;
	printv(v, n);

	int done = 1;
	do {
		if (!(done = next(v, n)))
			printv(v, n); /* P3 */
	} while (!done);
    getchar();
	return 0;
}

