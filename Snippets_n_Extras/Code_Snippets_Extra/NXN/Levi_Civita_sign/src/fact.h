#ifndef __FACT_H__
#define __FACT_H__

#include <stdio.h>
#include<stdlib.h>

#ifdef __cplusplus
extern "C"
{
#endif

int factorial(int num);

#ifdef __cplusplus
}
#endif

#endif

int factorial(int num);

int factorial(int num)
{
	int fact_num;
	fact_num=num;

	if (num<0)
	{
		printf("Invalid Value.\n");
		return (0);
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

