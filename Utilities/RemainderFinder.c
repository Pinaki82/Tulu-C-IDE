/*Remainder finder*/
#include <stdio.h>
#include <stdlib.h>
int tester(int x, int y);
void rem_div_calulator(int *a,
                       int *b,
                       int *rem,
                       float *rslt);
void do_again(void);

int main(void) {
  int a, b, rem, t;
  float d, e, rslt/*division result*/;
  a=fflush(stdin);
  b=fflush(stdin);
  d=fflush(stdin);
  e=fflush(stdin);
  rem=fflush(stdin);
  rslt=fflush(stdin);

  printf("Input a number and a divisor (with spaces) to find the remainder\n");
  scanf("%d %d",&a,&b);
  t=tester(a,b);
  if(t==1) {
    rem_div_calulator(&a,&b,&rem,&rslt);
  }
  else if(t==0) {
    getchar();
    fflush(stdin);
    do_again();
  }

  printf("remainder is %d\n",rem);
  printf("division result is %f\n",rslt);

  getchar();
  do_again();
}

int tester(int x,
           int y) {
  int t=0;
  if((x<y)||(y==0)||(x<0)||(y<0)) {
    printf(
      "Input Invalid..\n");
    t=0;
  }
  else {
    t=1;
  }
  return (t);
}

void rem_div_calulator(int *a,
                       int *b,
                       int *rem,
                       float *rslt) {
  float d, e;
  *rem=*a%*b;
  d=*a; //int to float conversion
  e=*b; //int to float conversion
  *rslt=d/e;
}

void do_again(void) {
  char keyprsd;
  printf("Do again? y/n  ");
  scanf("%c",&keyprsd);
  if((keyprsd!='n')&&(keyprsd!='N')) {
    keyprsd=fflush(stdin);
    main();
  }
  else {
    exit(0);
  }
}

